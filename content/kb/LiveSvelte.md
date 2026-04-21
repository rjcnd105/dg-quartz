---
publish: true
created: 2026-04-08T03:15:00Z
modified: 2026-04-08T03:20:00Z
tags:
  - kb
  - elixir
  - phoenix
  - liveview
  - svelte
  - frontend
---

LiveView에서 Svelte 컴포넌트를 렌더링하는 라이브러리. stateful 백엔드 프로세스와 stateful 프런트엔드 컴포넌트가 협업하는 패러다임을 제공한다.

## 핵심 패러다임

Sequin 팀이 발견한 "best-of-both-worlds" 접근 (출처: [[LiveView is best with Svelte]]):

**3가지 핵심 속성:**

1. 백엔드(LiveView)가 프런트엔드 컴포넌트의 props를 제어
2. 프런트엔드(Svelte)와 백엔드(LiveView) 모두 stateful
3. 양방향 비공개 통신 채널 — 어느 쪽이든 먼저 메시지를 보낼 수 있음

## 사용법

LiveView에서 `.svelte` 컴포넌트를 렌더링:

```elixir
~H"""
<.svelte
  name="MyForm"
  props={%{collections: @encoded_collections, errors: @encoded_errors}}
  socket={@socket}
/>
"""
```

Svelte에서 LiveView로 이벤트 전송 — `live` prop을 통해:

```js
// Svelte component
$: {
  live.pushEvent("form_updated", { form }, () => {});
}
```

LiveView에서 일반적인 Elixir 메시지 처리 방식으로 응답:

```elixir
def handle_event("form_updated", %{"form" => form}, socket) do
  params = decode_params(socket, form)
  {:noreply, merge_changeset(socket, params)}
end
```

## SPA 대비 장점

- **단일 라우팅**: 브라우저 라우팅이 백엔드에서 이루어짐 (SPA는 프런트엔드/API 이중 라우팅 필요)
- **stateful 백엔드**: 작업이 점진적 상태 변경으로 처리됨 (stateless API처럼 매번 재구성 불필요)
- **비공개 결합 통신**: 공개 API 경로를 오염시키지 않음. `pushEvent` 핸들러가 협업 Elixir 모듈에 명확히 존재
- **두 파일로 기능 분할**: API 모듈, 라우터, 컨트롤러 스택을 거치지 않음
- **간소화된 에러 처리**: 웹소켓이 열려 있으면 서버가 활성, 아니면 LiveView가 "연결 끊김" 배너를 표시

## 순수 LiveView 대비 장점

- 프런트엔드에서 상태와 상태 전환을 수용
- 프런트엔드/백엔드 경계가 명확
- Svelte의 성숙한 컴포넌트 생태계 활용 (애니메이션 등)
- 프런트엔드 코드가 극도로 단순해짐: `if/else` 블록 + 애니메이션 + `pushEvent`

## 실무 팁

- Elixir struct를 Svelte에 전달하기 전에 plain map으로 명시적 인코딩 권장
- LiveView가 데이터 가공(sort, filter, map 등)을 담당하므로 프런트엔드 로직 최소화
- Svelte 5의 runes로 더 쉬운 상태 관리 기대

## Svelte 선택 이유

React에는 LiveView와 유사하게 완전한 통합 라이브러리가 없었다. Svelte는 기본 상태 관리와 반응성에서 가장 가볍고 빠르며, `if/else` 템플릿이 삼항 연산자보다 직관적이다.

## 최신 동향 (2026-04)

### LiveSvelte 현재 상태

- **최신 버전**: v0.17.4 (2026-02-20), v0.18.0-rc0 (2026-03-19) RC 진행 중
- **Svelte 5 지원**: v0.15.0부터 Svelte 5 완전 지원. Svelte 4 문법도 하위 호환
- **요구사항**: Elixir 1.17+, OTP 27+ (네이티브 JSON 모듈 사용)

### 경쟁 라이브러리 등장

LiveSvelte와 동일한 패러다임(stateful 백엔드 + stateful 프런트엔드)을 다른 프런트엔드 프레임워크로 제공하는 라이브러리들이 성숙했다:

**[[LiveVue]]** (v1.0.1) — Vue.js + Phoenix LiveView:

- LiveSvelte의 포크에서 시작하여 독립적으로 진화
- Vite 기반, SSR 지원, TypeScript 통합
- JSON 패치를 통해 변경된 props만 WebSocket으로 전송
- Phoenix Streams와 투명하게 호환
- Chart.js, TipTap, Headless UI 등 Vue 라이브러리 사용 가능

**LiveReact** — React + Phoenix LiveView:

- `useLiveReact` 훅으로 서버에 이벤트 푸시
- React 생태계 활용 가능하지만 LiveSvelte/LiveVue 대비 통합 수준이 낮음

**LiveState** — 프레임워크 무관:

- 임베더블 웹 앱에 초점
- 어떤 프런트엔드 프레임워크나 바닐라 JS와도 작동
- Phoenix Channels 기반 실시간 통신

### 선택 기준

| 기준 | LiveSvelte | LiveVue | LiveReact |
|------|-----------|---------|-----------|
| 프레임워크 | Svelte 4/5 | Vue 3 | React |
| 성숙도 | 가장 높음 | 1.0 안정 | 상대적으로 초기 |
| SSR | 지원 | 지원 | 제한적 |
| TypeScript | 지원 | 네이티브 | 지원 |
| 번들 크기 | 가장 작음 | 중간 | 가장 큼 |

Vue 생태계에 익숙하다면 LiveVue가 LiveSvelte만큼 완성도 높은 대안이다. React의 경우 LiveReact보다는 LiveSvelte/LiveVue를 권장하는 커뮤니티 의견이 우세하다.

## 관련 링크

- [[LiveView 아키텍처]] — LiveView의 기본 동작 원리와 한계
- [[LiveView JS Commands]] — 서버에서 클라이언트 JS 트리거
