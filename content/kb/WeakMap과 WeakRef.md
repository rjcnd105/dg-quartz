---
publish: true
created: 2026-04-08T03:15:00Z
modified: 2026-04-08T03:15:00Z
tags:
  - kb
  - javascript
  - memory-management
---

# WeakMap과 WeakRef

JavaScript에서 객체에 대한 약한 참조(weak reference)를 유지하는 메커니즘이다. 강한 참조와 달리 GC가 해당 객체를 수거하는 것을 막지 않으므로, DOM 노드와 연관 데이터를 관리할 때 메모리 누수를 방지하는 핵심 도구다. (출처: [[Patterns for Memory Efficient DOM Manipulation with Modern Vanilla JavaScript]])

## WeakMap

`WeakMap`은 키가 반드시 객체여야 하며, 키 객체가 GC되면 해당 엔트리도 자동으로 제거된다. DOM 노드에 메타데이터를 연결할 때 유용하다. (출처: [[Patterns for Memory Efficient DOM Manipulation with Modern Vanilla JavaScript]])

```javascript
let DOMdata = { 'logo': 'Frontend Masters' };
let DOMmap = new WeakMap();
let el = document.querySelector(".FmLogo");
DOMmap.set(el, DOMdata);
console.log(DOMmap.get(el)); // { 'logo': 'Frontend Masters' }
el.remove(); // DOMdata가 GC 대상이 됨
```

일반 `Map`을 사용하면 DOM 노드가 제거되어도 Map이 강한 참조를 유지하므로 데이터가 GC되지 않는다.

## WeakRef

`WeakRef`는 개별 객체에 대한 약한 참조를 만든다. `deref()` 메서드로 원본 객체에 접근하되, GC가 이미 수거했으면 `undefined`를 반환한다. DOM 노드의 존재 여부에 따라 타이머나 콜백을 정리하는 패턴에 사용된다. (출처: [[Patterns for Memory Efficient DOM Manipulation with Modern Vanilla JavaScript]])

```javascript
class Counter {
  constructor(element) {
    this.ref = new WeakRef(element);
    this.start();
  }
  start() {
    this.timer = setInterval(() => {
      const element = this.ref.deref();
      if (element) {
        element.textContent = `Counter: ${++this.count}`;
      } else {
        // 요소가 GC됨 - 타이머 정리
        this.stop();
      }
    }, 1000);
  }
  // ...
}
```

## 주의사항

`WeakRef`는 편리하지만 성능 비용이 있다. 가능하면 명시적으로 참조를 관리하는 것이 더 낫고, `WeakRef`는 명시적 관리가 어려운 경우에 사용하는 것이 권장된다. (출처: [[Patterns for Memory Efficient DOM Manipulation with Modern Vanilla JavaScript]])

## 관련 문서

- [[DOM 조작 최적화]]
