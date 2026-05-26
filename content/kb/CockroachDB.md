---
publish: true
created: 2026-04-08T03:15:00Z
modified: 2026-04-08T03:15:00Z
tags:
  - kb
  - database
  - cockroachdb
  - distributed-sql
  - geo-partitioning
---

전 세계 분산 SQL 데이터베이스. Google Spanner에서 영감받아 상용 하드웨어에서 글로벌 스케일의 강력한 일관성을 제공한다. Postgres wire protocol 호환.

## 핵심 내용

### Spanner 기반 설계

Google의 Spanner 논문에 기반한다. Spanner는 원자 시계와 GPS 시계로 정확한 시간 동기화를 달성하지만, 상용 하드웨어에는 이런 장비가 없다 (출처: [[7 Databases in 7 Weeks for 2025]]).

**CockroachDB의 시계 해결책**:

- NTP 시계 동기화 지연을 고려하여 읽기를 재시도하거나 지연
- 노드 간 clock drift를 상호 비교
- 최대 offset 초과 시 해당 멤버를 종료

### Postgres Wire Protocol 호환

[[PostgreSQL]] wire protocol과 호환된다. 기존 Postgres 클라이언트 도구와 드라이버를 그대로 사용할 수 있다.

### Multi-Region 및 Geo-Partitioning

여러 지역에 걸친 데이터베이스 확장이 핵심 기능이다 (출처: [[7 Databases in 7 Weeks for 2025]]):

- **Table Localities** — 읽기/쓰기 트레이드오프에 따라 다양한 옵션 제공
- 수평 확장 + 강력한 일관성을 글로벌 스케일로

## 관련 링크

- [[PostgreSQL]] — Wire protocol의 원본. OLTP 단일 리전 시나리오
- [[FoundationDB]] — 또 다른 분산 데이터베이스 접근
- CockroachDB 공식: https://www.cockroachlabs.com/
- Spanner 논문: http://static.googleusercontent.com/media/research.google.com/en//archive/spanner-osdi2012.pdf
