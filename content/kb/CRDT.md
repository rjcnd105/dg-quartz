---
publish: true
created: 2026-04-08T03:20:00Z
modified: 2026-04-08T03:20:00Z
tags:
  - kb
  - glossary
---

Conflict-free Replicated Data Type. 분산 시스템에서 여러 노드가 독립적으로 데이터를 수정해도 나중에 자동으로 일관된 상태로 병합되는 자료구조다.

## 왜 필요한가

오프라인 환경이나 네트워크가 불안정한 분산 시스템에서는 각 노드가 독립적으로 데이터를 수정한 후 나중에 동기화해야 한다. 일반 자료구조는 이때 충돌이 발생하지만, CRDT는 수학적으로 충돌이 불가능하도록 설계되어 있다.

## 기본 유형

- **Counter** — 각 노드의 증감을 합산하여 최종 값을 구한다 (G-Counter, PN-Counter)
- **Set** — 추가/제거 연산이 교환 법칙을 만족하도록 설계 (OR-Set 등)
- **Register** — 최종 쓰기 승리(LWW) 또는 다중 값 유지 방식으로 단일 값을 관리

## 관련 문서

- [[SQLite]] — CR-SQLite 확장이 CRDT를 활용하여 분산 동기화 지원
