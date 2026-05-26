---
publish: true
created: 2026-04-08T03:20:00Z
modified: 2026-04-08T03:20:00Z
tags:
  - kb
  - glossary
---

분산 시스템에서 여러 노드가 동일한 상태에 합의(consensus)하기 위한 알고리즘이다. Paxos의 대안으로, 이해하기 쉽게 설계하는 것을 명시적 목표로 삼았다.

## 핵심 개념

Raft는 합의 문제를 세 가지 하위 문제로 분리한다:

- **Leader Election** — 노드들 중 하나가 리더로 선출된다. 리더만 클라이언트 요청을 처리하고, 나머지는 follower로서 리더의 결정을 복제한다. 리더가 장애를 일으키면 새 선거가 시작된다.
- **Log Replication** — 리더가 받은 명령을 로그에 기록하고, 과반수 follower가 이를 복제하면 committed로 간주한다.
- **Safety** — 어떤 상황에서도 committed된 항목이 손실되지 않도록 보장한다.

## Paxos와의 비교

Paxos는 동일한 문제를 해결하지만 매우 난해하여 올바른 구현이 어렵다. Raft는 "이해 가능성(understandability)"을 설계 원칙으로 삼아 교육과 구현 모두에서 Paxos보다 접근하기 쉽다.

## 관련 문서

- [[CockroachDB]] — Raft를 사용하여 분산 트랜잭션 합의를 달성
