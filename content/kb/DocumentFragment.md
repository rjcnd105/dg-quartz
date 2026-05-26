---
publish: true
created: 2026-04-08T03:35:00Z
modified: 2026-04-08T03:35:00Z
tags:
  - kb
  - glossary
  - javascript
  - dom
---

DOM 노드를 임시로 담아두는 경량 컨테이너. 실제 DOM 트리에 속하지 않아서 reflow/repaint 없이 여러 요소를 한 번에 준비할 수 있다.

## 사용법

```javascript
const fragment = document.createDocumentFragment();
for (let i = 0; i < 1000; i++) {
  const li = document.createElement('li');
  li.textContent = `Item ${i}`;
  fragment.appendChild(li);
}
document.getElementById('list').appendChild(fragment); // 한 번에 삽입
```

## 왜 빠른가

개별 `appendChild` 호출은 매번 reflow를 유발한다. DocumentFragment에 먼저 모아두면, `appendChild(fragment)` 한 번으로 전체가 삽입되어 reflow가 1회만 발생한다.

## 관련 링크

- [[DOM 조작 최적화]] — DocumentFragment를 포함한 DOM 성능 패턴
- [[Garbage Collection]] — DOM 조작 시 GC 부하 관리
