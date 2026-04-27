---
publish: true
created: 2026-04-08T03:15:00Z
modified: 2026-04-08T03:15:00Z
tags:
  - kb
  - react
  - hooks
  - state-management
---

# useSyncExternalStore

React 18에서 도입된 훅으로, React 외부의 데이터 소스(external store)를 구독하고 동기화하는 공식 메커니즘이다. 여러 컴포넌트 인스턴스에서 공유되는 외부 데이터를 일관성 있게 읽고 반응할 수 있다. (출처: [[Example of Using useSyncExternalStore with LocalStorage  56kode]])

## subscribe/getSnapshot 패턴

`useSyncExternalStore`는 두 가지 함수를 인자로 받는다. (출처: [[Example of Using useSyncExternalStore with LocalStorage  56kode]])

- **subscribe**: 외부 스토어의 변경을 감지하는 구독 함수. 콜백을 등록하고, 클린업 함수를 반환한다.
- **getSnapshot**: 현재 스토어 값을 동기적으로 반환하는 함수.

```typescript
const subscribe = (callback: () => void): (() => void) => {
  window.addEventListener("storage", callback);
  return () => window.removeEventListener("storage", callback);
};

const getSnapshot = (): Theme => {
  return (localStorage.getItem("app-theme") as Theme) || "light";
};

const theme = useSyncExternalStore(subscribe, getSnapshot);
```

## 크로스 탭 동기화

브라우저의 `storage` 이벤트를 subscribe 함수에서 감지하면, 다른 탭에서 LocalStorage를 변경했을 때 현재 탭의 React 컴포넌트도 자동으로 리렌더링된다. 같은 탭 내에서 `localStorage.setItem`을 호출할 때는 `storage` 이벤트가 발생하지 않으므로, `window.dispatchEvent(new Event("storage"))`를 수동으로 트리거해야 한다. (출처: [[Example of Using useSyncExternalStore with LocalStorage  56kode]])

```typescript
const setTheme = (newTheme: Theme) => {
  localStorage.setItem(THEME_STORAGE_KEY, newTheme);
  window.dispatchEvent(new Event("storage")); // 같은 탭 내 동기화
};
```

## LocalStorage를 External Store로 사용하는 예시

테마 토글 구현에서 `useThemeStore` 커스텀 훅으로 `useSyncExternalStore`를 감싸 `[theme, setTheme]` 튜플을 반환한다. 여러 컴포넌트(Header, Footer, ThemeToggler)가 동일한 훅을 사용하면 모두 같은 테마 상태를 공유하며, 탭 간에도 동기화된다. (출처: [[Example of Using useSyncExternalStore with LocalStorage  56kode]])

## 활용 사례

- 테마/다크 모드 동기화 (LocalStorage)
- 로그인/로그아웃 상태 크로스 탭 동기화
- WebSocket/API를 통한 실시간 데이터 동기화
- 전역 알림 시스템
- 장바구니 동기화

(출처: [[Example of Using useSyncExternalStore with LocalStorage  56kode]])

## 관련 문서

- [[TanStack Router 파일 기반 라우팅]]
- [[useEffect 안티패턴]] — React 훅 오용 패턴. useSyncExternalStore는 "외부 시스템 동기화"의 올바른 대체 중 하나
