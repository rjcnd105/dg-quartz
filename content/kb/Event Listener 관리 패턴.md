---
publish: true
created: 2026-04-08T03:15:00Z
modified: 2026-04-08T03:15:00Z
tags:
  - kb
  - javascript
  - dom
  - events
---

# Event Listener 관리 패턴

DOM 이벤트 리스너를 효율적으로 등록하고 정리하는 패턴들이다. 리스너를 제대로 정리하지 않으면 메모리 누수와 예기치 않은 동작이 발생한다. (출처: [[Patterns for Memory Efficient DOM Manipulation with Modern Vanilla JavaScript]])

## removeEventListener

가장 기본적인 정리 방법이다. 이벤트 핸들러 내부에서 `removeEventListener`를 호출하여 수동으로 제거한다. 핸들러가 명명된 함수여야 한다(익명 함수는 제거 불가). (출처: [[Patterns for Memory Efficient DOM Manipulation with Modern Vanilla JavaScript]])

```javascript
function handleClick() {
  console.log("clicked!");
  el.removeEventListener("click", handleClick);
}
el.addEventListener("click", handleClick);
```

## once 옵션

`addEventListener`의 세 번째 인자에 `{ once: true }`를 전달하면 리스너가 한 번 실행된 후 자동으로 제거된다. 일회성 이벤트에 적합하다. (출처: [[Patterns for Memory Efficient DOM Manipulation with Modern Vanilla JavaScript]])

```javascript
el.addEventListener('click', handleClick, { once: true });
```

## Event Delegation

동적으로 추가/제거되는 자식 요소들에 개별 리스너를 달지 않고, 상위 요소에 하나의 리스너를 등록하여 `event.target`으로 이벤트 발생 요소를 판별하는 패턴이다. 이벤트 버블링을 활용한다. (출처: [[Patterns for Memory Efficient DOM Manipulation with Modern Vanilla JavaScript]])

```javascript
rootEl.addEventListener('click', function (event) {
  if (event.target.closest('.target-element')) doSomething();
});
```

`matches(selector)`는 정확히 해당 요소에만 매칭되므로, 자식 요소가 있는 경우 `closest(selector)`를 사용해야 한다. 동적으로 요소를 삽입/제거할 때 리스너를 매번 등록/해제할 필요가 없다는 점이 핵심이다.

## AbortController로 일괄 해제

`AbortController`의 `signal`을 여러 `addEventListener`에 전달하면, `controller.abort()` 한 번으로 모든 리스너를 일괄 해제할 수 있다. (출처: [[Patterns for Memory Efficient DOM Manipulation with Modern Vanilla JavaScript]])

```javascript
const controller = new AbortController();
const { signal } = controller;

button.addEventListener('click', () => console.log('clicked!'), { signal });
window.addEventListener('resize', () => console.log('resized!'), { signal });
document.addEventListener('keyup', () => console.log('pressed!'), { signal });

// 모든 리스너를 한 번에 제거
controller.abort();
```

컴포넌트 해제 시 관련 이벤트들을 깔끔하게 정리해야 하는 상황에서 특히 유용하다.

## 관련 문서

- [[DOM 조작 최적화]]
