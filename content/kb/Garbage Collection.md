---
publish: true
created: 2026-04-08T03:20:00Z
modified: 2026-04-08T03:20:00Z
tags:
  - kb
  - glossary
---

프로그램이 더 이상 사용하지 않는 메모리를 런타임이 자동으로 회수하는 메커니즘이다. JavaScript, Java, Go 등 대부분의 고수준 언어가 GC를 내장하고 있다.

## Mark-and-Sweep

JavaScript 엔진(V8 등)이 사용하는 기본 GC 알고리즘이다:

1. **Mark** — 루트(전역 객체, 스택 변수 등)에서 시작하여 참조 그래프를 순회하며 도달 가능한 객체를 표시한다
2. **Sweep** — 표시되지 않은 객체를 메모리에서 해제한다

참조가 남아 있으면 GC가 회수하지 못한다 — 이것이 메모리 누수의 원인이다.

## DOM 조작과 GC

DOM 노드를 제거해도 JavaScript 변수가 해당 노드를 참조하고 있으면 GC가 회수하지 못한다. 대량의 DOM 조작이 발생하면 GC 부하가 커져 프레임 드롭이 생길 수 있다. [[WeakMap과 WeakRef]]를 사용하면 GC를 방해하지 않는 약한 참조를 유지할 수 있다.

## 관련 문서

- [[DOM 조작 최적화]] — GC 부하를 줄이는 DOM 조작 패턴
- [[WeakMap과 WeakRef]] — GC 친화적인 참조 관리
