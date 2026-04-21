---
publish: true
created: 2026-04-08T03:15:00Z
modified: 2026-04-08T03:20:00Z
tags:
  - kb
  - database
  - sqlite
  - local-first
  - embedded-database
---

애플리케이션에 직접 내장되는 local-first 데이터베이스. 단순 로컬 저장소를 넘어 분산 아키텍처와 CRDT 기반 동기화까지 확장되고 있다.

## 핵심 내용

### Local-First 아키텍처

SQLite 데이터베이스가 애플리케이션과 직접 co-locate된다. WhatsApp과 Signal이 채팅을 로컬 SQLite DB로 저장하는 것이 대표적 사례다 (출처: [[7 Databases in 7 Weeks for 2025]]).

### 분산 및 복제 도구

단순 로컬 DB를 넘어 더 창의적인 토폴로지가 가능해졌다 (출처: [[7 Databases in 7 Weeks for 2025]]):

- **Litestream** — 스트리밍 백업. SQLite를 프로덕션 DB로 사용할 수 있게 하는 핵심 도구
- **LiteFS** — 분산 액세스 제공 (Fly.io)
- **CR-SQLite** — CRDT 기반 확장. 변경 집합 병합 시 충돌 해결 불필요. Corrosion 프로젝트에서 활용

### Rails 8.0과 SQLite

37signals가 SQLite에 올인했다. Rails 8.0에서 `database.yml`로 여러 SQLite DB를 조작하도록 구성하고, Solid Queue 등의 모듈을 구축했다 (출처: [[7 Databases in 7 Weeks for 2025]]).

### Bluesky PDS

Bluesky는 Personal Data Server에 SQLite를 사용한다. 모든 사용자가 자신만의 SQLite 데이터베이스를 가지는 구조다 (출처: [[7 Databases in 7 Weeks for 2025]]).

## 실전 사용

- Postgres 클라이언트-서버 모델을 SQLite local-first로 마이그레이션 가능한지 검토
- [[DuckDB]]로 SQLite 데이터의 분석 쿼리를 오프로드할 수 있다 (DuckDB가 SQLite를 직접 읽기 가능)

## 최신 동향 (2026-04)

### 최신 버전

2026년 4월 기준 SQLite 3.51.3 (2026-03-13 릴리스). 25주년 기념 릴리스인 SQLite 3.50.0 (2025-05)에서 주요 기능이 추가되었다:

- **Unicode 함수** — `unistr()`, `unistr_quote()` 추가
- **Lock timeout API** — `sqlite3_setlk_timeout()`으로 잠금 타임아웃 설정
- **JSONB 최적화**
- **rsync 유틸리티 개선**

### 프로덕션 배포 확대

SQLite가 "프로토타이핑용"을 넘어 프로덕션 워크로드로 본격 확산 중이다:

- **Turso** — LibSQL 기반 edge SQLite 서비스
- **Cloudflare D1** — Cloudflare의 edge SQLite 서비스
- **LibSQL** — SQLite의 오픈소스 포크로 서버 모드, 복제 등 추가 기능 제공
- **Litestream** — 스트리밍 백업으로 프로덕션 사용을 가능하게 하는 핵심 도구 (기존 기술, 여전히 활발)

### Wasm/비동기 지원

Android Jetpack의 `androidx.sqlite:sqlite-2.7.0-alpha01` (2026-03)에서 js/wasmJs 타겟과 비동기 드라이버 API (`openAsync()`, `prepareAsync()`, `stepAsync()`) 추가. 웹 플랫폼에서의 SQLite 활용이 확대되고 있다.

## 관련 링크

- [[DuckDB]] — SQLite 읽기를 지원하는 분석 특화 임베디드 DB
- [[PostgreSQL]] — 클라이언트-서버 모델의 대안
- Litestream: https://litestream.io/
- LiteFS: https://fly.io/docs/litefs/
- CR-SQLite: https://github.com/vlcn-io/cr-sqlite
