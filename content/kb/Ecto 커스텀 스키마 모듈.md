---
publish: true
created: 2026-04-08T02:47:00Z
modified: 2026-04-08T03:15:00Z
tags:
  - kb
  - elixir
  - ecto
  - phoenix
  - pattern
---

`Ecto.Schema`를 래핑하는 프로젝트 전용 스키마 모듈. UUID, 마이크로초 타임스탬프 등 반복 설정을 중앙화.

## 핵심 내용

모든 Ecto 스키마에 동일한 3줄을 반복하는 대신, 래퍼 모듈을 만들어 `use MyApp.Schema`로 대체 (출처: [[The Modifications I Make to Every New Phoenix Project]]):

```elixir
defmodule MyApp.Schema do
  defmacro __using__(_) do
    quote do
      use Ecto.Schema
      @primary_key {:id, :binary_id, autogenerate: true}
      @foreign_key_type :binary_id
      @timestamps_opts [type: :utc_datetime_usec]
    end
  end
end
```

**왜 `utc_datetime_usec`인가**: 기본 `utc_datetime`은 초 단위 절삭 → 같은 초에 삽입된 레코드 정렬 불가. `DateTime.truncate(:second)` 호출도 불필요해짐.

**Repo 설정도 함께**: `config/config.exs`에서 migration 기본값도 맞춰줘야 스키마와 마이그레이션이 일관됨:

```elixir
config :my_app, MyApp.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id],
  migration_timestamps: [type: :utc_datetime_usec]
```

## Embedded Schema와의 관계

커스텀 스키마 모듈은 DB 연결 스키마에 주로 적용되지만, embedded schema에도 동일한 원리가 적용될 수 있다 (출처: [[Structs and Embedded Schemas in Elixir Beyond Maps  AppSignal Blog]]). `embedded_schema`는 내부적으로 `schema` 매크로를 `source: nil`로 호출하므로, `use Ecto.Schema` 대신 `use MyApp.Schema`를 사용하면 embedded schema에도 동일한 기본값(UUID primary key 등)이 자동 적용된다.

단, embedded schema는 DB 테이블 없이 동작하므로 `@primary_key`와 `@foreign_key_type` 설정이 실질적 의미가 없는 경우가 많다. API 입력 검증용 Command 패턴이나 LiveView form 전용 스키마처럼 DB와 무관한 용도에는 별도의 경량 래퍼를 고려할 수 있다.

자세한 내용은 [[Ecto Embedded Schema]] 참조.

## 관련 링크

- [[Phoenix 프로젝트 초기 설정]] — 이 패턴이 포함된 전체 설정 목록
- [[Ecto Embedded Schema]] — DB 없이 사용하는 Ecto 스키마
- 관련 vault 노트: [[elixir tips, patterns]], [[Ecto]]
