---
publish: true
created: 2026-04-08T03:15:00Z
modified: 2026-04-08T03:20:00Z
tags:
  - kb
  - database
  - postgresql
  - rdbms
---

"Just use Postgres"가 밈이 된 이유가 있는 범용 관계형 데이터베이스. ACID 준수, 풍부한 확장 생태계, 물리적/논리적 복제를 지원한다.

## 핵심 내용

### Extension 생태계

PostgreSQL의 핵심 차별점은 확장(extension) 시스템이다. 다른 데이터베이스에서 찾기 어려운 수준의 유연성을 제공한다 (출처: [[7 Databases in 7 Weeks for 2025]]):

- **AGE** — 그래프 데이터 구조 + Cypher 쿼리 언어 지원
- **TimescaleDB** — 시계열 워크로드
- **Hydra Columnar** — 열형 스토리지 엔진 대안

확장을 직접 작성하는 것도 가능하다.

### Wire Protocol

Postgres wire protocol이 범용 Layer 7 프로토콜로 자리잡고 있다. Postgres가 아닌 서비스들도 클라이언트 호환성을 위해 이 프로토콜을 채택한다 (출처: [[7 Databases in 7 Weeks for 2025]]). [[CockroachDB]]가 대표적인 예시다.

### MVCC

Multi-Version Concurrency Control은 PostgreSQL의 동시성 제어 핵심이지만 "변덕스러울 수 있다(can be fickle)". 트랜잭션 격리와 vacuum 동작의 이해가 필요하다.

### PGlite (Wasm)

PostgreSQL을 Wasm으로 실행할 수 있는 PGlite 프로젝트가 존재한다. 풍부한 에코시스템과 합리적인 기본 동작에 Wasm 지원까지 더해져 학습 가치가 높다 (출처: [[7 Databases in 7 Weeks for 2025]]).

## 최신 동향 (2026-04)

### PostgreSQL 18 출시 (2025-09)

PostgreSQL 18이 2025년 9월 25일에 릴리스되었다. 2026년 4월 기준 최신 패치 버전은 18.3이다. 주요 기능:

- **비동기 I/O 서브시스템** — sequential scan, bitmap heap scan, vacuum 등에서 최대 3배 성능 향상
- **uuidv7()** — 타임스탬프 순서가 보장되는 UUID 생성 함수 내장
- **Virtual Generated Columns** — 읽기 시점에 값을 계산하는 가상 생성 컬럼 (이제 기본값)
- **OAuth 인증** 지원
- **Temporal Constraints** — PRIMARY KEY, UNIQUE, FOREIGN KEY에 범위 기반 제약조건 적용
- **Skip Scan** — 다중 컬럼 B-tree 인덱스를 더 많은 경우에 활용 가능
- **메이저 버전 업그레이드 개선** — 업그레이드 시간 단축, 업그레이드 후 기대 성능 도달 시간 감소

### Extension 생태계 확장

- **pgvector** — v0.7.0에서 halfvec(2바이트 float, 4,000차원), sparsevec(1,000 비영 차원), binary vector 인덱싱(64,000차원) 추가. 2026년 현재 프로덕션 RAG 시스템, 추천 엔진, 시맨틱 검색에 광범위하게 사용
- **AI 스택** — pgvector, pgvectorscale, pgai, pg\_vectorize로 구성된 PostgreSQL 네이티브 AI 도구 체인이 형성
- **PGlite** — pgvector, PostGIS 등 확장을 동적으로 로드하는 메커니즘 지원. TypeScript/JavaScript 클라이언트로 브라우저, Node.js, Bun에서 실행 가능

### Google Cloud의 PostgreSQL 투자

Google Cloud가 2026년 3월 PostgreSQL 생태계에 대한 장기 투자 계획을 발표했다.

## 관련 링크

- [[CockroachDB]] — Postgres wire protocol 호환 분산 SQL
- [[DuckDB]] — 분석 쿼리에 특화된 임베디드 데이터베이스
- [[SQLite]] — 또 다른 접근의 임베디드 데이터베이스 (OLTP)
- PGlite: https://pglite.dev/
- PostgreSQL 공식: https://www.postgresql.org/
