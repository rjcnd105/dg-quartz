---
publish: true
created: 2026-04-08T03:15:00Z
modified: 2026-04-08T03:15:00Z
tags:
  - kb
  - graph-algorithm
  - clustering
---

그래프의 edge density를 기반으로 커뮤니티를 탐지하는 알고리즘. Embedding이나 벡터 DB 없이 그래프 토폴로지만으로 클러스터링한다.

## 핵심 내용

Leiden은 Louvain 알고리즘의 개선판으로, modularity를 최적화하여 밀접하게 연결된 노드 그룹(커뮤니티)을 찾는다. Embedding 기반 클러스터링과 달리 **그래프 구조 자체가 유사성 신호**가 된다 (출처: [[safishamsigraphify AI coding assistant skill (Claude Code, Codex, OpenCode, OpenClaw). Turn any folder of code, docs, papers, or images into a queryable knowledge graph|Graphify README]]).

Graphify에서의 활용: LLM이 추출한 semantic similarity edge가 그래프에 이미 포함되어 있으므로, Leiden이 이 edge들을 커뮤니티 탐지에 자연스럽게 반영한다. 구조적 관계(import, call graph)와 의미적 관계(semantic similarity)가 하나의 그래프에서 동시에 클러스터링된다.

Python에서는 graspologic 라이브러리의 구현을 사용한다.

## 관련 링크

- [[Knowledge Graph Extraction]] — Leiden을 커뮤니티 탐지에 활용하는 지식 그래프 추출 기법
