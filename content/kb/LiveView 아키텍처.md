---
publish: true
created: 2026-04-08T03:15:00Z
modified: 2026-04-08T03:20:00Z
tags:
  - kb
  - elixir
  - phoenix
  - liveview
  - architecture
---

Phoenix LiveView는 stateful 서버 프로세스가 페이지를 렌더링하고 DOM을 점진적으로 업데이트하는 웹 애플리케이션 패러다임이다. 프런트엔드 마이크로서비스를 제거하면서도 SPA 수준의 인터랙션을 제공한다.

## 핵심 개념

전통적 서버 렌더링(stateless)과 SPA(stateful client + stateless server)의 중간 지점 (출처: [[LiveView is best with Svelte]]):

- **서버가 stateful**: 사용자의 경로, 작업 중인 리소스, 상태를 서버 프로세스가 유지
- **점진적 DOM 업데이트**: 전체 페이지를 다시 보내지 않고 변경된 부분만 클라이언트에 푸시
- **프런트엔드 마이크로서비스 제거**: DB 쿼리와 렌더링이 인접 함수에서 이루어짐. API 레이어, 라우터, 컨트롤러 스택을 거치지 않음
- **Elixir/OTP 통합**: LiveView는 프로세스(pid, state, inbox)이므로 PubSub 등 OTP 메커니즘에 자연스럽게 참여

## 3가지 컴포넌트 타입

LiveView에는 세 가지 다른 유형의 컴포넌트가 존재한다 (출처: [[LiveView is best with Svelte]]):

| 타입 | 상태 | 프로세스 | 비유 |
|------|------|---------|------|
| **LiveView** | stateful | 독립 프로세스 (pid 보유) | React stateful component |
| **LiveComponent** | stateful | 부모 LiveView 프로세스에 종속 | React stateful component (제한적) |
| **Component** | stateless | 없음 | React functional component |

**LiveView는 항상 최상위 부모 컴포넌트**이다. LiveComponent와 Component는 그 하위에 렌더링된다.

### LiveComponent의 한계

LiveComponent는 자체 프로세스가 아니라 LiveView에서 호출하는 모듈이다:

- 부모 LiveView가 모든 하위 컴포넌트의 상태를 보유
- LiveView에 `send`, LiveComponent에 `send_update` — 통신 방식이 다름
- PubSub 등 시스템 전체 메커니즘에 직접 참여 불가
- LiveView → LiveComponent 리팩토링이 번거로움 (구문, 수명주기, 통신 방식 모두 다름)

## 한계점

### 클라이언트 측 상태의 불가피성

서버와 사용자 사이에 빛의 속도 제한이 존재한다. 애니메이션, 툴팁, DOM 요소 토글 등은 클라이언트 측에서 처리해야 한다. 이를 위해 JS Commands와 Hooks를 사용하지만:

- 핵심 LiveView와 사이드 체인으로 연결된 느낌
- JS/Hooks를 많이 쓸수록 LiveView 외부에 DOM 상태가 늘어남
- React처럼 상태와 액션이 통일된 모델이 아님

### 레이턴시 경계의 모호함

React에서는 서버 호출 시점이 명확하다(`fetch` 호출). LiveView에서는 모든 상태가 서버 측이라 레이턴시 없이는 React와 비슷해 보이지만, 레이턴시가 증가하면 상당히 다른 패러다임이 된다.

## 최신 동향 (2026-04)

### Phoenix LiveView 1.1 (현재 v1.1.28)

LiveView가 1.0을 넘어 1.1로 진화하면서 핵심적인 기능이 추가되었다:

- **Keyed Comprehensions** — `:for`에 `:key` 속성을 사용하여 리스트 항목별 change tracking 가능. 단일 항목 변경 시 해당 변경분만 전송. 내부적으로 LiveComponent로 최적화
- **Colocated JavaScript** — JS 코드를 LiveView 모듈과 함께 배치 가능
- **Portals** — 콘텐츠를 DOM 트리의 다른 위치로 텔레포트
- **JS Commands 개선** — `JS.to_encodable/1` 추가, `%JS{}`가 `JSON.Encoder`와 `Jason.Encoder` 프로토콜 구현
- **TypeScript 타입 선언** — 모든 공개 JavaScript API에 타입 선언 제공
- **HTMLFormatter 개선** — 태그 주변 공백 보존 향상, `<style>`, `<script>` 태그용 TagFormatter behaviour 추가

### 컴포넌트 모델 변화

Keyed comprehensions의 도입으로 LiveComponent의 사용 패턴이 변화하고 있다. 이전에는 리스트 항목별 change tracking을 위해 LiveComponent가 필요했지만, 이제 `:key` 속성만으로 동일한 효과를 얻을 수 있다. LiveComponent는 자체 이벤트 핸들링이 필요한 경우에 집중하게 되었다.

## 관련 링크

- [[LiveSvelte]] — LiveView의 한계를 Svelte로 보완하는 접근
- [[LiveView JS Commands]] — 서버에서 클라이언트 JS를 트리거하는 패턴
- [[Ecto Embedded Schema]] — LiveView form을 구동하는 embedded schema 활용
