---
publish: true
created: 2026-04-08T03:20:00Z
modified: 2026-04-08T03:20:00Z
tags:
  - kb
  - glossary
---

DOM 이벤트가 발생한 요소에서 시작하여 부모 요소를 거쳐 `document`까지 위로 전파되는 방식이다. 대부분의 DOM 이벤트가 기본적으로 버블링된다.

## 이벤트 전파의 3단계

1. **Capturing** — `document`에서 대상 요소까지 아래로 내려간다
2. **Target** — 이벤트가 실제 발생한 요소에 도달한다
3. **Bubbling** — 대상 요소에서 `document`까지 위로 올라간다

`addEventListener`의 세 번째 인자로 `{ capture: true }`를 전달하면 capturing 단계에서 이벤트를 잡을 수 있다. 기본값은 bubbling 단계다.

## Event Delegation이 가능한 이유

버블링 덕분에 자식 요소에서 발생한 이벤트가 부모까지 전파된다. 따라서 부모에 리스너 하나만 등록해도 모든 자식의 이벤트를 `event.target`으로 감지할 수 있다. 동적으로 추가/제거되는 요소에도 별도의 리스너 관리가 필요 없어진다.

## 관련 문서

- [[Event Listener 관리 패턴]] — Event delegation 등 실전 활용 패턴
