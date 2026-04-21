---
publish: true
created: 2026-04-08T03:15:00Z
modified: 2026-04-08T03:15:00Z
tags:
  - kb
  - javascript
  - dom
  - performance
---

# DOM 조작 최적화

브라우저 DOM을 직접 조작할 때 메모리 효율과 렌더링 성능을 높이기 위한 패턴들이다. 프레임워크 없이 바닐라 JavaScript로 성능이 중요한 앱을 만들 때 핵심이 되며, VS Code처럼 대규모 애플리케이션이 프레임워크 대신 직접 DOM 조작을 선택하는 이유이기도 하다. (출처: [[Patterns for Memory Efficient DOM Manipulation with Modern Vanilla JavaScript]])

## 기존 요소 재사용 우선

새 DOM 노드를 생성/삭제하는 것보다 `classList.add('show')` 또는 `el.style.display = 'block'`으로 숨기기/보이기를 전환하는 것이 항상 더 빠르다. GC 호출과 복잡한 클라이언트 로직이 줄어들기 때문이다. (출처: [[Patterns for Memory Efficient DOM Manipulation with Modern Vanilla JavaScript]])

접근성을 고려해야 한다. `display: none`은 스크린 리더에서도 숨기지만, 시각적으로만 숨기고 보조 기술에는 노출하려면 별도 방법이 필요하다.

## textContent vs innerText

`innerText`는 현재 스타일을 인식하여 숨겨진 요소의 텍스트를 제외하지만, 이 과정에서 reflow를 강제하므로 느리다. 읽기 목적이라면 `textContent`가 훨씬 빠르다. (출처: [[Patterns for Memory Efficient DOM Manipulation with Modern Vanilla JavaScript]])

## insertAdjacentHTML vs innerHTML

`innerHTML`은 기존 DOM을 먼저 파괴한 후 새로 삽입하지만, `insertAdjacentHTML`은 기존 DOM을 유지한 채 삽입하므로 더 빠르다. 삽입 위치도 `"afterbegin"`, `"beforeend"` 등으로 유연하게 지정할 수 있다. (출처: [[Patterns for Memory Efficient DOM Manipulation with Modern Vanilla JavaScript]])

## Template 태그 + appendChild 패턴

가장 빠른 DOM 삽입 방법은 `<template>` 태그로 HTML 템플릿을 정의하고, `cloneNode(true)`로 복제한 뒤 `appendChild`나 `insertAdjacentElement`로 삽입하는 것이다. (출처: [[Patterns for Memory Efficient DOM Manipulation with Modern Vanilla JavaScript]])

```javascript
const template = document.getElementById('card_template');
const element = template.content.cloneNode(true).firstElementChild;
container.appendChild(element);
```

## DocumentFragment로 배치 삽입

[[DocumentFragment]]는 활성 DOM 트리에 속하지 않는 경량 문서 객체로, 여러 요소를 한 번에 삽입할 때 사용한다. 개별 삽입 대비 reflow와 repaint를 최소화한다. (출처: [[Patterns for Memory Efficient DOM Manipulation with Modern Vanilla JavaScript]])

```javascript
const fragment = document.createDocumentFragment();
for (let i = 0; i < 1000; i++) {
  const li = document.createElement('li');
  li.textContent = `Item ${i}`;
  fragment.appendChild(li);
}
document.getElementById('myList').appendChild(fragment);
```

## 참조 관리

DOM 노드를 제거할 때 남아있는 참조가 GC를 방해할 수 있다. [[WeakMap과 WeakRef]]를 사용하면 DOM 노드와 연관 데이터 간 약한 참조를 유지하여 메모리 누수를 방지할 수 있다. (출처: [[Patterns for Memory Efficient DOM Manipulation with Modern Vanilla JavaScript]])

## 메모리 프로파일링

Chrome DevTools의 Memory 탭에서 Heap Snapshot을 찍어 DOM 조작 전후를 비교하면 메모리 증가량과 누수를 확인할 수 있다. Performance 탭에서는 JavaScript 실행 시간(노란색), 렌더링(보라색), 페인팅(초록색)을 시각화하여 DOM 조작 병목을 찾을 수 있다. (출처: [[Patterns for Memory Efficient DOM Manipulation with Modern Vanilla JavaScript]])

## 관련 문서

- [[WeakMap과 WeakRef]]
- [[Event Listener 관리 패턴]]
