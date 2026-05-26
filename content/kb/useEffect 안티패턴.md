---
publish: true
created: 2026-04-17T09:00:00Z
modified: 2026-04-17T09:00:00Z
tags:
  - kb
  - react
  - frontend
  - hooks
---

`useEffect`는 React가 관리하지 않는 외부 시스템과의 동기화 용도. 내부 상태·props 기반 로직에 쓰면 불필요한 re-render와 버그를 만든다. 결정 기준: **"외부 시스템과 동기화하는가?"** 아니면 쓰지 마라.

## 핵심 내용

Neciu Dan (2026-04)에 따르면 React 개발자 대부분이 `useEffect`를 첫 번째 escape hatch로 기억해서 기본으로 reach한다 (출처: [[You really, really, really don't need an effect! I swear!]]).

### 외부 시스템의 정의

React가 모르는 모든 것 — WebSocket, DOM 측정, `IntersectionObserver`·`navigator.onLine` 같은 브라우저 API, 3rd-party 위젯(지도·에디터), `setInterval` 타이머.

**외부 시스템이 아닌 것**: 자신의 props·state·파생값, 사용자 이벤트(click/submit). 이건 React가 이미 안다.

경계 사례: `document.title`. 기술적으로 DOM이므로 `useEffect` 유효.

### 7가지 안티패턴과 대안

| 패턴 | 안티패턴 | 올바른 방식 |
|------|----------|-------------|
| 데이터 변환 | `useEffect(() => setFiltered(data.filter(...)), [data])` | `const filtered = data.filter(...)` (비싸면 `useMemo`) |
| 사용자 이벤트 | flag 상태 + `useEffect(() => { if (clicked) ... })` | 이벤트 핸들러에서 직접 실행 |
| prop 변경 시 state 리셋 | `useEffect(() => setState(default), [prop])` | `<Component key={prop} />` |
| 데이터 페칭 | `useEffect` + fetch + ignore flag + cache + dedup | TanStack Query (`useQuery`, `useMutation`) |
| 부모 알림 | `useEffect(() => onChange(isOn), [isOn])` | 이벤트 핸들러에서 `setState`와 함께 `onChange` 직접 호출 |
| 이펙트 체인 | `state → effect → state → effect → state` | 하나의 이벤트 핸들러에서 batched `setState` |
| 외부 스토어 구독 | `useEffect` + `addEventListener` + `setState` | [[useSyncExternalStore]] |

### 왜 `useEffect`가 틀렸나

각 경우의 공통 문제:

- **Double render**: `useEffect` + `setState`는 최소 2번 render. 파생값은 render 중 계산하면 1번.
- **Stale intermediate state**: prop 변경 후 effect 발화 전 한 번, 발화 후 한 번 — 사용자가 중간 상태 목격.
- **Race condition**: 페칭에서 순서 역전 가능. ignore flag 직접 관리 필요.
- **Strict Mode mount 2회**: 정리 버그가 없어도 안 함.

### 데이터 페칭 특이 사항

기술적으로는 외부 시스템(네트워크)이라 `useEffect` 정당함. 하지만 race condition·캐시·중복 제거·윈도우 focus 재검증 등을 직접 구현하면 **결국 데이터 페칭 라이브러리를 만들게 된다**. TanStack Query가 이미 해둠. 작은 프로젝트 외에는 라이브러리 사용.

### `useEffect`가 적절한 경우

- WebSocket 연결 (mount 시 open, unmount 시 close)
- 3rd-party 위젯 초기화 (지도, 리치 텍스트 에디터)
- DOM 측정 → `useLayoutEffect` 사용 (paint 전 실행, flash 방지)
- 브라우저 API 구독 (`IntersectionObserver`, `ResizeObserver`)
- 마운트 시 analytics page view (사용자가 _봤&#xB2E4;_&#xB294; 의미)

사용자 **행동** tracking은 이벤트 핸들러에서 (event context 보존, 중복 발화 방지).

### Enforce

ESLint plugin 활용:

- `eslint-plugin-react-you-might-not-need-an-effect` — 불필요한 effect 감지
- `eslint-plugin-react-hooks` 의 `set-state-in-effect` — effect 내 동기 `setState` 감지

### AI 도구와의 맥락

Claude Code·Copilot·Cursor 등 AI assistant는 훈련 데이터 분포로 인해 `useEffect` 남용 성향. 저자는 Claude Code skill(`react-tips-skill` 플러그인 내 `no-unnecessary-effects`)을 제공.

## 관련 링크

- [[useSyncExternalStore]] — 외부 스토어 구독의 올바른 훅
- [[Event Listener 관리 패턴]] — 3rd-party DOM 이벤트 정리 (useEffect가 적절한 경우의 패턴)
- React 공식 문서: "You Might Not Need an Effect"
- ESLint plugin: `eslint-plugin-react-you-might-not-need-an-effect`
