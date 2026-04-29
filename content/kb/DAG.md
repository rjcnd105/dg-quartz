---
publish: true
created: 2026-04-29T04:54:11Z
modified: 2026-04-29T04:54:11Z
tags:
  - kb
  - glossary
  - graph
---

DAG(Directed Acyclic Graph)는 방향이 있는 edge를 가진 graph 중 cycle이 없는 구조다. 어떤 node에서 edge 방향을 따라 이동해 다시 같은 node로 돌아올 수 없다.

## 핵심 내용

DAG는 dependency를 표현할 때 자주 쓰인다. 예를 들어 task B가 task A 이후에만 실행될 수 있으면 `A -> B` edge를 둔다. Cycle이 없기 때문에 topological order를 만들 수 있고, 어떤 작업을 먼저 실행해야 하는지 계산할 수 있다.

## 관련 링크

- [[AI Organisation]] — OMC의 task dependency graph가 DAG로 표현된다
