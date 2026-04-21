---
publish: true
created: 2026-04-08T03:15:00Z
modified: 2026-04-08T03:15:00Z
tags:
  - kb
  - elixir
  - ecto
  - pattern
---

데이터베이스 테이블에 연결되지 않은 Ecto 스키마. 원래 `jsonb` 컬럼을 위해 설계되었지만, `ecto`와 `ecto_sql` 분리 이후 DB 없이 독립적으로 활용되는 범위가 크게 확장되었다.

## 내부 동작

`embedded_schema`는 본질적으로 Ecto 기능이 추가된 struct이다 (출처: [[Structs and Embedded Schemas in Elixir Beyond Maps  AppSignal Blog]]).

1. `use Ecto.Schema`가 `__using__` 매크로를 호출하여 11개의 accumulating module attribute를 등록 (fields, associations, primary keys 등)
2. `embedded_schema` 매크로는 내부적으로 `schema` 매크로를 `source: nil`로 호출한다 — DB 테이블 없는 schema와 동일
3. `field`, `embeds_one` 등 helper를 import하여 스키마 정보를 module attribute에 축적
4. `defstruct`를 호출하여 plain struct 정의
5. `__changeset__`과 `__schema__` 함수를 모듈에 정의 — changeset과 introspection 지원

`@enforce_keys`는 기본 설정되지 않지만, `embedded_schema` 호출 직전에 수동 설정 가능.

## Changeset과 Validation

embedded schema는 changeset과 결합하여 타입 강제, 포맷 검증, 필수 필드 확인을 제공한다:

```elixir
def changeset(address, params) do
  address
  |> cast(params, [:street, :city, :postcode])
  |> validate_required([:street, :city, :postcode])
  |> validate_format(:postcode, ~r/^\d{5}$/)
end
```

DB 백업 테이블 없이도 이 모든 검증이 작동한다.

## Command Pattern (API 입력 사전 검증)

embedded schema로 API 입력을 파싱·검증하는 "Command" 패턴 (출처: [[Structs and Embedded Schemas in Elixir Beyond Maps  AppSignal Blog]]):

- DB 접근 없이 수행 가능한 검증을 사전 처리 (이메일 형식, 필수 필드, 숫자 범위 등)
- 유효하지 않은 요청을 빠르게 거부하여 리소스 절약 (_fail fast_)
- changeset이 유효하면 `Changeset.apply_changes/1`로 struct를 추출하여 비즈니스 로직에 전달
- API와 [[LiveView 아키텍처|LiveView]] 관리자 대시보드에서 비즈니스 로직 재사용 가능

```elixir
defmodule CreateUserCommand do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :email, :string
    field :first_name, :string
    field :age, :integer
  end

  def changeset(command, params) do
    command
    |> cast(params, [:email, :first_name, :age])
    |> validate_required([:email, :first_name])
    |> validate_format(:email, ~r/@/)
    |> validate_number(:age, greater_than_or_equal_to: 18)
  end
end
```

## LiveView Form 지원

LiveView는 changeset 래퍼인 `%Form{}` struct를 통해 form을 구동한다. 핵심 포인트:

- `Phoenix.Component.to_form(changeset)`로 changeset → form 변환
- form을 구동하는 스키마가 DB 테이블에 연결될 필요 없음
- Command 패턴의 embedded schema를 재사용하면 API와 LiveView가 약 2/3의 코드를 공유
- form에 맞지 않으면 LiveView 모듈 내에 커스텀 embedded schema를 정의하거나 **schemaless changeset** 사용 가능

### Schemaless Changeset

스키마 없이 changeset을 만드는 방법. form 변환 시 `to_form(changeset, as: :my_name)`으로 이름 지정 필요.

### Action 설정 주의사항

embedded schema 기반 changeset에서는 `Repo.insert`/`Repo.update`가 호출되지 않으므로 `:action` 필드가 `nil`로 유지된다. 검증 오류를 표시하려면 `Map.put(changeset, :action, :validate)` 등으로 수동 설정해야 한다.

## 관련 링크

- [[Elixir Struct]] — embedded schema의 기반이 되는 struct
- [[Ecto 커스텀 스키마 모듈]] — 프로젝트 전용 스키마 래퍼
- [[LiveView JS Commands]] — LiveView에서의 클라이언트 상호작용
