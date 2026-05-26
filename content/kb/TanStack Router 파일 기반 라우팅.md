---
publish: true
created: 2026-04-08T03:15:00Z
modified: 2026-04-08T03:20:00Z
tags:
  - kb
  - react
  - tanstack
  - routing
---

# TanStack Router 파일 기반 라우팅

TanStack Router의 파일 기반 라우팅 시스템과 프로덕션에서의 실전 패턴을 다룬다. 타입 안전 파라미터, 데이터 로딩, 인증 가드, 에러 바운더리 등을 지원하며, 파일 구조가 곧 라우트 구조가 된다. (출처: [[Skeletons in My Codebase Tanstack in Production]])

## 파일 이름 규칙

| 패턴 | 예시 | URL | 용도 |
|------|------|-----|------|
| `index.tsx` | `routes/index.tsx` | `/` | 정확한 경로 매칭 |
| `$param` | `routes/users/$userId.tsx` | `/users/123` | 동적 세그먼트 |
| `route.tsx` | `routes/chat/route.tsx` | `/chat` | 레이아웃 (자식을 감싸는 부모) |
| `_pathless/` | `routes/_auth/route.tsx` | URL 변경 없음 | URL 중첩 없는 공유 가드 |
| `-folder/` | `routes/chat/-components/` | 라우트 아님 | 비공개 컴포넌트/훅 |
| `$.tsx` | `routes/docs/$.tsx` | `/docs/a/b/c` | Catch-all |

## 라우트 구조 접근법

세 가지 접근법을 비교한 실전 경험이 정리되어 있다. (출처: [[Skeletons in My Codebase Tanstack in Production]])

### Pathless 레이아웃 (`_authenticated/`)

URL에 영향 없이 인증 가드를 적용할 수 있지만, `_authenticated/dashboard.tsx`와 루트의 `dashboard.tsx`가 충돌하는 등 라우트 중복 문제가 발생하기 쉽다. 유지보수가 어렵다.

### Route Groups (`(auth)/`)

파일 정리용으로만 사용되며 URL이나 라우트 세그먼트에 영향을 주지 않는다. `route.tsx`로 공유 레이아웃/가드를 추가할 수 없어 한계가 있다.

### Feature 기반 `route.tsx` 레이아웃 (권장)

각 기능 디렉토리에 `route.tsx`를 두어 레이아웃 역할을 하게 한다. 가장 깔끔하고 예측 가능한 구조다. `-components/` 규칙으로 관련 컴포넌트를 함께 배치한다.

```
routes/
├── chat/
│   ├── route.tsx          # 레이아웃 + 인증 가드
│   ├── $chatId.tsx        # 개별 채팅 페이지
│   └── -components/       # 채팅 전용 컴포넌트
└── settings/
    ├── route.tsx          # 레이아웃 + 인증 가드
    ├── profile.tsx
    └── -components/
```

## beforeLoad 인증 가드

`beforeLoad`는 async 함수를 지원하므로 인증 상태가 확정될 때까지 기다린 후 리다이렉트 결정을 내릴 수 있다. 동기적 가드의 race condition(세션 로딩 중 미인증으로 판단하여 리다이렉트 후 다시 돌아오는 현상)을 방지한다. (출처: [[Skeletons in My Codebase Tanstack in Production]])

```tsx
export const Route = createFileRoute('/chat')({
  beforeLoad: async (opts) => {
    await requireAuthenticated({
      authClient: opts.context.authClient,
      location: opts.location,
    })
  },
  component: ChatLayout,
  pendingComponent: AppShellSkeleton,
})
```

핵심: 인증에는 loading, authenticated, unauthenticated 세 가지 상태가 있으며, 가드는 loading이 아닌 두 상태에서만 결정을 내려야 한다.

## 부모 라우트의 레이아웃 상속

부모 `route.tsx`에서 정의한 인증 가드, 로딩 상태, 에러 바운더리, 공유 UI는 모든 자식 라우트에 자동 상속된다. 자식 라우트는 고유한 데이터 로딩과 렌더링에만 집중하면 된다. (출처: [[Skeletons in My Codebase Tanstack in Production]])

## pendingComponent와 Skeleton 패턴

모든 라우트에 `pendingComponent`를 지정하여 `beforeLoad`와 `loader` 실행 중 빈 화면 대신 스켈레톤 UI를 보여준다. 스켈레톤은 최종 레이아웃 구조와 일치시키고, 동적 콘텐츠 부분만 사각형 플레이스홀더로 표시하여 시각적 깜빡임을 최소화한다. (출처: [[Skeletons in My Codebase Tanstack in Production]])

## beforeLoad vs useEffect 리다이렉트

`beforeLoad`에서 리다이렉트하면 컴포넌트 렌더링 전에 발생하여 빈 레이아웃 깜빡임이 없고, SSR 호환이 가능하며, 모든 네비게이션 로직이 라우트 설정에 집중된다. `useEffect`는 컴포넌트가 마운트/렌더링된 후 실행되므로 깜빡임이 발생한다. (출처: [[Skeletons in My Codebase Tanstack in Production]])

## 최신 동향 (2026-04)

### 현재 버전: v1.168.x

TanStack Router는 빠른 릴리스 주기를 유지하며 2026년 4월 기준 v1.168.10이다. 파일 기반 라우팅의 기본 규칙과 API 표면은 안정적으로 유지되고 있다.

### Signal Graph 기반 Reactive Core 리팩토링

TanStack Router의 내부 반응성 모델이 근본적으로 변경되었다:

- **이전**: 모든 reactive state가 하나의 큰 객체 `router.state`에 저장
- **이후**: 독립적으로 변경되는 작은 store들의 signal graph로 분리. `router.state`는 여전히 존재하지만, 이제 이 store들에서 파생(derived)되는 값

구체적으로 location, status, loading, transitions, redirects 등 최상위 store와 active/pending/cached match pool별 per-match store로 분리되었다. TanStack Store의 alien-signals 마이그레이션 위에 구축되었다.

**실전 영향:**

- 네비게이션 시 구독(subscription) 트리거 감소로 성능 향상
- `useMatch`, `useLocation`, `Link` 등 공개 API는 동일하게 유지 — 마이그레이션 불필요
- route 변경이 더 지역적으로(locally) 업데이트되어 불필요한 리렌더링 감소

## 관련 문서

- [[useSyncExternalStore]]
