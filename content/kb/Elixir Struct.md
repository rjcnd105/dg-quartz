---
publish: true
created: 2026-04-08T03:15:00Z
modified: 2026-04-08T03:15:00Z
tags:
  - kb
  - elixir
  - data-structure
---

Elixir의 struct는 추가 기능이 있는 named map이다. `defstruct` 매크로로 정의하며, 일반 map보다 엄격하고 강력한 데이터 구조를 제공한다.

## 내부 구조

struct는 내부적으로 map이며, `__struct__` 키가 자동으로 추가되어 일반 map과 구분된다 (출처: [[Structs and Embedded Schemas in Elixir Beyond Maps  AppSignal Blog]]). `defstruct` 매크로는 `:ets`(Erlang의 in-memory table system)를 사용하여 컴파일 타임에 키 유효성 검사를 수행한다.

동일 모듈에서 `defstruct`를 두 번 호출하는 것은 불가능하다.

## Strict Keys

struct는 정의된 키만 허용하는 컴파일 타임 보장을 제공한다. 정의되지 않은 키로 struct를 생성하면 오류가 발생한다.

`[]` (Access behavior)로 접근하면 struct가 `Access` protocol을 구현하지 않기 때문에 실패한다. dot notation(`.`)으로만 접근 가능.

## Required Keys

`@enforce_keys`로 필수 키를 지정할 수 있다. 필수 키 없이 struct를 생성하면 컴파일 타임 오류가 발생한다.

## Pattern Matching in Function Clauses

struct는 함수 절에서 map보다 강력한 pattern matching을 제공한다:

- `%User{name: name}` — 특정 struct 타입 매칭. 컴파일러가 유효한 필드인지 정적 검증
- `%User{}` 또는 `%PowerUser{}` — 여러 struct 타입 매칭 가능
- `%_{}`(또는 `%__struct__{}`) — 모든 struct 매칭 (일반 map 제외)

`%User{}` 의 `User` 부분은 `__struct__` 키 값에 대한 pattern matching이다.

## Dialyzer Types

Dialyzer 사용 시 struct 모듈 내에 `t` type을 선언하는 것이 관례 (출처: [[Structs and Embedded Schemas in Elixir Beyond Maps  AppSignal Blog]]):

```elixir
@type t :: %__MODULE__{
  name: String.t(),
  email: String.t(),
  age: non_neg_integer()
}
```

Elixir 자체 타입 시스템이 성장하면서 이 패턴은 점차 대체될 전망이다. 현재로서는 Dialyzer typespec이 여전히 유용하며, 향후 Elixir type specification으로 마이그레이션될 것으로 예상된다.

## struct의 장점 요약

- **컴파일 타임 검증**: 유효하지 않은 키 사용 방지
- **필수 키 적용**: `@enforce_keys`로 누락 방지
- **강력한 pattern matching**: 함수 절에서 타입 기반 분기
- **정적 분석**: Dialyzer와 함께 타입 안전성 확보
- **자기 문서화**: 데이터 구조의 명확한 계약

## 관련 링크

- [[Ecto Embedded Schema]] — struct 위에 Ecto 기능을 추가한 확장
- [[typed_struct와 domo]] — struct boilerplate 감소 패키지 (주의 필요)
