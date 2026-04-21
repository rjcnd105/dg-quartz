---
publish: true
created: 2026-04-08T03:15:00Z
modified: 2026-04-08T03:20:00Z
tags:
  - kb
  - database
  - duckdb
  - olap
  - embedded-database
  - analytics
---

인프로세스 임베디드 분석(OLAP) 데이터베이스. SQL을 사용하여 CSV, JSON, Parquet 등 다양한 데이터 소스를 직접 쿼리할 수 있는 "query-anything" 엔진이다.

## 핵심 내용

### Query-Anything 접근

DuckDB의 핵심 강점은 SQL 하나로 다양한 데이터 소스를 직접 쿼리할 수 있다는 것이다 (출처: [[7 Databases in 7 Weeks for 2025]]):

- CSV, TSV, JSON 네이티브 지원
- **Parquet** 포맷 지원
- [[SQLite]] DB 직접 읽기 가능

Bluesky firehose를 DuckDB로 쿼리하는 사례가 존재한다.

### SQLite와의 차이

[[SQLite]]와 마찬가지로 인프로세스 임베디드 DB이지만, OLTP가 아닌 **OLAP**에 초점을 맞춘다. 분석 쿼리에서 SQLite보다 훨씬 빠르다.

### 확장 생태계

[[PostgreSQL]]처럼 확장 시스템이 있지만 상대적으로 젊은 생태계다. 커뮤니티 확장 중 `gsheets`(Google Sheets 쿼리)가 주목할 만하다 (출처: [[7 Databases in 7 Weeks for 2025]]).

## 실전 사용

- Python 노트북이나 Evidence 같은 도구와 결합하여 데이터 분석/처리
- SQLite local-first 아키텍처에서 분석 쿼리만 DuckDB로 오프로드하는 구조 가능

## 최신 동향 (2026-04)

### DuckDB 1.5.0 "Variegata" (2026-03)

DuckDB 1.5.0이 2026년 3월에 릴리스되었다. 주요 신기능:

- **VARIANT 타입** — Snowflake의 semi-structured VARIANT 데이터 타입에서 영감. JSON 타입과 달리 텍스트가 아닌 typed binary 데이터로 물리 저장. 각 행이 자체 타입 정보를 포함하여 압축과 쿼리 성능 향상. JSON 분석이 JSON shredding 덕분에 최대 100배 빠름
- **GEOMETRY 타입** — 내장 지오메트리 타입 추가
- **CLI 리뉴얼** — 새로운 색상 팔레트, 동적 프롬프트, 페이저 등 터미널 사용 경험 개선

### DuckLake — 오픈 Lakehouse 포맷

DuckDB 팀이 만든 새로운 데이터 레이크 포맷:

- SQL과 Parquet 기반의 통합 데이터 레이크 + 카탈로그 포맷
- 메타데이터를 [[PostgreSQL]] 또는 [[SQLite]] 카탈로그 DB에 저장, 데이터는 S3 호환 객체 스토어에 Parquet으로 저장
- **Data Inlining** — 소규모 업데이트를 카탈로그에 직접 저장하여 "small files problem" 해결. Iceberg 대비 쿼리 926배, 적재 105배 빠른 벤치마크
- DuckLake 1.0이 2026년 4월 DuckDB v1.5.2와 함께 출시 예정
- 다수의 DuckLake 클라이언트가 동일 카탈로그 DB에 동시 접속 가능

### DuckDB v2.0 예고

다음 메이저 버전인 DuckDB v2.0이 2026년 9월 릴리스 예정이다.

## 관련 링크

- [[SQLite]] — OLTP 특화 임베디드 DB. DuckDB와 상호보완적
- [[ClickHouse]] — 대규모 분석 워크로드용 서버 기반 OLAP
- [[PostgreSQL]] — 확장 생태계의 선배
- Evidence: https://evidence.dev/
- DuckDB 공식: https://duckdb.org/
