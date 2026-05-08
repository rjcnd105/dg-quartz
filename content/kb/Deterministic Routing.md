---
publish: true
created: 2026-05-08T08:30:39Z
modified: 2026-05-08T08:30:39Z
tags:
  - kb
  - distributed-systems
  - database
  - architecture
---

Deterministic routing은 같은 key의 요청을 반복 가능한 규칙으로 같은 owner node에 보내, 분산 시스템의 stale read와 coordination 비용을 줄이는 패턴이다.

## 핵심 내용

Benjamin Cane의 설명에 따르면 replication만으로는 write 직후 read가 다른 replica에 도착하는 문제를 완전히 없애기 어렵다. Asynchronous replication은 stale read를 허용하고, synchronous replication은 latency와 coordination 비용을 키운다. Deterministic routing은 데이터를 모든 곳으로 복제해 일관성을 얻기보다, 요청을 데이터가 있는 곳으로 보내는 방향의 해법이다 (출처: [[Deterministic routing is one of the most effective ways distributed systems reduce consistency problems at scale • Benjamin Cane]]).

일반적인 구현은 key hashing, consistent hashing, partition map, shard range 같은 방식이다. 핵심은 `user123` 같은 routing key가 항상 같은 owner를 가리키도록 해서 session ownership, cache ownership, workflow partitioning, queue partitioning을 안정적으로 만든다는 점이다.

## 배치 위치

Routing logic은 세 위치에 둘 수 있다.

- Client-side routing: client가 partition map을 알고 직접 owner node로 보낸다.
- Proxy/router tier: 중앙 router가 node로 forward한다.
- Server-side forwarding: 아무 node에 도착해도 owner node로 내부 forward한다.

세 방식 모두 tradeoff가 있다. Client-side는 빠르지만 client/library 배포와 map 갱신이 필요하고, proxy는 client를 단순하게 만들지만 별도 tier가 생기며, server-side forwarding은 client에는 쉽지만 cluster discovery와 forwarding failure path가 복잡해진다.

## 해석 경계

Deterministic routing은 replication을 대체하지 않는다. Owner node 장애, durability, failover는 여전히 replication이나 consensus 계층이 맡아야 한다. 따라서 이 패턴은 [[Raft Consensus]] 같은 합의 알고리즘이나 [[결정론적 시뮬레이션 테스팅]]과 경쟁하는 개념이 아니라, request ownership을 줄여 coordination 면적을 줄이는 architecture pattern으로 보는 편이 맞다.

## 관련 링크

- [[결정론적 시뮬레이션 테스팅]] — 분산 시스템 실패를 재현 가능한 환경에서 검증하는 패턴
- [[Raft Consensus]] — replicated state의 합의 알고리즘
- [[Managed Agent Architecture]] — agent sandbox/session routing에서도 ownership과 failure boundary를 분리하는 인접 패턴
