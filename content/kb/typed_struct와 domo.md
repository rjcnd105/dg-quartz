---
publish: true
created: 2026-04-08T03:15:00Z
modified: 2026-04-08T12:00:00Z
tags:
  - kb
  - elixir
  - tooling
  - caution
---

Elixir struct의 boilerplate를 줄이기 위한 패키지들. 유용하지만 유지보수와 컴파일 성능에 주의가 필요하다.

## typed\_struct

`defstruct` + `@enforce_keys` + `@type t` 선언을 하나의 DSL로 통합한다 (출처: [[Structs and Embedded Schemas in Elixir Beyond Maps  AppSignal Blog]]):

```elixir
defmodule User do
  use TypedStruct

  typedstruct do
    field :name, String.t(), enforce: true
    field :email, String.t(), enforce: true
    field :age, non_neg_integer()
  end
end
```

**주의사항**: 최근 업데이트가 없어 장기 유지보수에 우려가 있다. Elixir 자체 타입 시스템 발전으로 유용성이 감소할 전망.

## domo

typed\_struct 위에 `new/1`, `new!/1` 등 유틸리티 함수를 자동 생성한다.

**심각한 문제점** (V7 팀의 실무 경험):

- 컴파일 시간이 크게 증가
- 컴파일 deadlock이 정기적으로 발생
- 제거를 심각하게 고려 중인 상태

## 향후 전망

Elixir 타입 시스템이 성장하면서 Dialyzer typespec이 대체될 예정이다. 이에 따라 typed\_struct/domo 같은 패키지의 필요성도 감소할 것이다. 새 프로젝트에서는 표준 `defstruct` + Elixir 컴파일러 타입 체크를 사용하며, typed\_struct/domo 도입은 불필요하다.

> [!info] 갱신
> \~~이전: 표준 `defstruct` + Dialyzer typespec 조합을 권장 (출처: [[Structs and Embedded Schemas in Elixir Beyond Maps  AppSignal Blog]])~~ → 표준 `defstruct` + Elixir 컴파일러 타입 체크 사용. typed\_struct/domo 도입 불필요 (출처: 최신 동향 조사, 2026-04)

## 최신 동향 (2026-04)

### Elixir 타입 시스템의 급속한 진전

Elixir의 set-theoretic 타입 시스템이 빠르게 발전하면서 typed\_struct/domo의 존재 의의가 줄어들고 있다:

- **Elixir 1.17** (2024-06) — set-theoretic 타입이 컴파일러에 최초 도입
- **Elixir 1.18** — 패턴과 반환 타입의 추론 구현
- **Elixir 1.19** (2025-10) — 익명 함수 포함 모든 구문의 타입 추론 (가드 제외), 컴파일 속도 최대 4배 향상
- **Elixir 1.20** (2026-05 예정, RC 진행 중) — 모든 언어 구문의 타입 추론, 의존성 간 추론

### Typed Struct가 컴파일러에 내장될 전망

Elixir 1.20 이후 로드맵에 **typed struct 메커니즘의 컴파일러 내장**이 포함되어 있다. struct 패턴 매칭과 필드 타입 전파가 컴파일러 수준에서 지원되면, typed\_struct 패키지의 핵심 기능이 대체된다.

- **v1.21** (2026-11 예정) — recursive/parametric 타입, typed struct 메커니즘 탐색
- **v1.22** (2027-05 예정) — set-theoretic 타입 시그니처 도입, 기존 Erlang Typespecs 대체 시작

### 현재 권장사항

- **새 프로젝트**: 표준 `defstruct` + Elixir 컴파일러 타입 체크 사용. typed\_struct/domo 도입 불필요
- **기존 프로젝트**: typed\_struct 사용 중이라면 당장 제거할 필요는 없지만, domo의 컴파일 성능 문제가 있다면 제거 권장
- **domo**: 컴파일 deadlock 문제가 여전히 존재하며, Elixir 네이티브 타입 시스템으로의 전환을 준비하는 것이 현실적

## 관련 링크

- [[Elixir Struct]] — 기본 struct 메커니즘
- [[Elixir 개발 도구]] — 프로젝트 필수 도구
