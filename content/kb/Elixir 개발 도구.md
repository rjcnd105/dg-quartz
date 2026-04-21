---
publish: true
created: 2026-04-08T02:47:00Z
modified: 2026-04-08T02:47:00Z
tags:
  - kb
  - elixir
  - tooling
  - dx
---

Phoenix/Elixir 프로젝트에서 기본으로 추가해야 할 개발 도구들.

## 핵심 내용

`mix phx.new`에 포함되지 않지만 실무에서 필수적인 의존성 (출처: [[The Modifications I Make to Every New Phoenix Project]]):

**Credo** — 정적 분석. 문체적 실수를 잡아주며 CI 파이프라인 필수. `mix credo`로 실행.

- https://github.com/rrrene/credo

**Styler** — 자동 포매팅. Credo가 권장만 한다면 Styler는 자동 수정. PR에서 스타일 논쟁 제거. `.formatter.exs`에 플러그인 등록 필요.

- https://github.com/adobe/elixir-styler

**mix test.watch** — 파일 저장 시 자동 테스트 재실행. TDD 필수 도구. `MIX_ENV=test`로 설정해야 함 (기본은 dev).

- https://github.com/lpil/mix-test.watch

## 관련 링크

- [[Phoenix 프로젝트 초기 설정]] — 이 도구들이 포함된 전체 프로젝트 설정
- 관련 vault 노트: [[elixir tips, patterns]]
