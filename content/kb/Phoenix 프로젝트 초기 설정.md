---
publish: true
created: 2026-04-08T02:40:00Z
modified: 2026-04-08T02:40:00Z
tags:
  - kb
  - phoenix
  - elixir
  - ecto
---

`mix phx.new`의 기본값을 실무에 맞게 바꾸는 설정들. UUID, 마이크로초 타임스탬프, 커스텀 스키마 모듈, 필수 의존성.

## 핵심 내용

Phoenix 기본 생성기의 문제와 해결 (출처: [[The Modifications I Make to Every New Phoenix Project]]):

**1. UUID 기본키** — 분산 시스템에서 정수 ID 대신 `binary_id` 사용이 자연스러움. Elixir/Erlang의 분산 성향 고려.

**2. `utc_datetime_usec`** — 기본 `utc_datetime`은 초 단위 절삭. 동일 초 내 레코드 정렬 불가. `DateTime.truncate(:second)` 호출 필요 없어짐.

**3. 커스텀 스키마 모듈** — 매 스키마에 3개 어노테이션을 반복하는 대신 래퍼 모듈 생성:

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

`use MyApp.Schema`로 모든 스키마에 자동 적용.

**4. Repo 설정** (`config/config.exs`):

```elixir
config :my_app, MyApp.Repo, migration_primary_key: [type: :binary_id]
config :my_app, MyApp.Repo, migration_foreign_key: [type: :binary_id]
config :my_app, MyApp.Repo, migration_timestamps: [type: :utc_datetime_usec]
```

**5. 필수 의존성**: Credo (정적 분석), Styler (자동 포매팅 — PR 스타일 논쟁 제거), mix test.watch (TDD 자동 재실행, `MIX_ENV=test` 설정).

## 실전 사용

John Curran이 만든 커스텀 생성기로 위 설정을 자동화:

```bash
mix archive.install hex phx_new_john_elm_labs
mix phx.new.john_elm_labs
```

`phx.gen.auth`도 포함: `mix phx.gen.auth Accounts User users --binary-id`

## 관련 링크

- 관련 vault 노트: [[elixir tips, patterns]], [[Ecto]]
- 생성기 GitHub: https://github.com/John-Elm/phx\_gen\_auth\_john\_elm\_labs
