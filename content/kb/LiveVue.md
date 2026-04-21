---
publish: true
created: 2026-04-08T03:35:00Z
modified: 2026-04-08T03:35:00Z
tags:
  - kb
  - elixir
  - phoenix
  - vue
---

LiveView에서 Vue.js 컴포넌트를 렌더링하는 라이브러리. [[LiveSvelte]]의 Vue.js 버전으로, LiveSvelte 포크에서 시작해 독립 진화했다.

## 핵심 특징

- **v1.0.1** (2026-04 기준) — 프로덕션 레디
- SSR (Server-Side Rendering) 지원
- TypeScript 완전 지원
- Phoenix Streams 투명 호환
- LiveSvelte와 동일한 props 전달 패러다임: LiveView assigns → Vue props

## LiveSvelte 대비

| | LiveSvelte | LiveVue |
|---|-----------|---------|
| 프레임워크 | Svelte 5 | Vue 3 |
| SSR | 지원 | 지원 |
| TypeScript | 지원 | 완전 지원 |
| 성숙도 | v0.17+ (초기 프로젝트) | v1.0 (안정) |
| 팀 경험 | Svelte 경험 필요 | Vue 경험 활용 가능 |

선택 기준: 팀이 이미 익숙한 프레임워크에 따라 결정. 기능적 차이보다 생태계/인력 기준이 중요.

## 관련 링크

- [[LiveSvelte]] — Svelte 기반 대안
- [[LiveView 아키텍처]] — LiveView의 기본 구조와 한계
