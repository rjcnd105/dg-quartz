---
publish: true
created: 2026-04-08T03:15:00Z
modified: 2026-04-08T03:15:00Z
tags:
  - kb
  - database
  - clickhouse
  - olap
  - columnar
  - analytics
---

열형(columnar) 스토리지 기반의 분석 특화 데이터베이스. 수평 확장과 계층형 스토리지를 지원하며, 대규모 실시간 분석 워크로드에 적합하다.

## 핵심 내용

### OLTP + OLAP 조합

"데이터베이스를 두 개만 고르라면 Postgres와 ClickHouse" — Postgres가 OLTP를 담당하고, ClickHouse가 OLAP를 담당하는 조합이 추천된다 (출처: [[7 Databases in 7 Weeks for 2025]]).

### 수평 확장 및 샤드 스토리지

매우 높은 ingest rate를 수평 확장(horizontal scaling)과 샤드 스토리지로 지원한다. [[DuckDB]]로 처리하기엔 너무 큰 데이터셋이나 실시간 분석이 필요한 경우에 적합하다.

### 계층형 스토리지 (Tiered Storage)

"핫" 데이터와 "콜드" 데이터를 분리하여 저장한다. GitLab이 이 기능을 활용하는 사례가 문서화되어 있다 (출처: [[7 Databases in 7 Weeks for 2025]]).

### 운영 편의성

배포, 확장, 백업이 잘 문서화되어 있으며 CPU governor 설정까지 다루는 수준이다. 운영이 즐겁다고 평가된다.

### chDB

ClickHouse의 임베디드 버전. [[DuckDB]]와 직접 비교가 가능하다.

## 관련 링크

- [[DuckDB]] — 소규모 분석을 위한 임베디드 OLAP
- [[PostgreSQL]] — OLTP 파트너
- ClickHouse 공식: https://clickhouse.com/
- GitLab tiered storage 문서: https://docs.gitlab.com/ee/development/database/clickhouse/tiered\_storage.html
