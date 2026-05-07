---
publish: true
created: 2026-04-29T04:54:11Z
modified: 2026-05-07T03:26:38Z
tags:
  - kb
  - glossary
  - graph
---

DAG(Directed Acyclic Graph)는 방향이 있는 edge를 가진 graph 중 cycle이 없는 구조다. 어떤 node에서 edge 방향을 따라 이동해 다시 같은 node로 돌아올 수 없다.

## 핵심 내용

DAG는 dependency를 표현할 때 자주 쓰인다. 예를 들어 task B가 task A 이후에만 실행될 수 있으면 `A -> B` edge를 둔다. Cycle이 없기 때문에 topological order를 만들 수 있고, 어떤 작업을 먼저 실행해야 하는지 계산할 수 있다.

## 실무 맥락

DAG는 build system, workflow engine, data pipeline, package dependency, causal graph, multi-agent task graph에 모두 쓰인다. 핵심 invariant는 "의존 방향을 따라 다시 자기 자신으로 돌아올 수 없음"이다. Cycle이 생기면 topological sort가 불가능해지고, executor는 어떤 작업부터 시작할지 결정할 수 없다.

## 해석 경계

DAG는 dependency ordering에는 강하지만 stateful retry, dynamic scheduling, resource contention, long-running feedback loop를 자동으로 표현하지 않는다. 그런 영역은 DAG 위에 scheduler policy나 [[Finite State Machine]]이 추가로 필요하다.

## 관련 링크

- [[AI Organisation]] — OMC의 task dependency graph가 DAG로 표현된다

## 관련 문서

- NetworkX DAG algorithms: https://networkx.org/documentation/stable/reference/algorithms/dag.html
- NetworkX topological sort: https://networkx.org/documentation/stable/reference/algorithms/generated/networkx.algorithms.dag.topological\_sort.html
