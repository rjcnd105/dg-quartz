---
publish: true
created: 2026-04-08T03:15:00Z
modified: 2026-04-08T03:15:00Z
tags:
  - kb
  - database
  - foundationdb
  - key-value-store
  - distributed-systems
---

정렬된 key-value 스토어이자 데이터베이스를 위한 "foundation". Layer 개념으로 스토리지 엔진과 데이터 모델을 분리하며, 시뮬레이션 테스팅의 선구자다.

## 핵심 내용

### Layer 개념

FoundationDB는 데이터베이스라기보다 데이터베이스의 기반(foundation)이다. 스토리지 엔진을 데이터 모델에 묶지 않고 Layer로 분리한다 (출처: [[7 Databases in 7 Weeks for 2025]]):

- **Record Layer** — 구조화된 레코드 저장
- **Document Layer** — 문서 모델 (MongoDB 유사)
- Tigris Data가 자체 레이어를 구축한 사례가 있음

### 의도적 제약 (Limits Set Us Free)

트랜잭션에 의도적 제약을 걸어 대규모 ACID를 달성한다 (출처: [[7 Databases in 7 Weeks for 2025]]):

- 트랜잭션 당 영향 데이터 10MB 상한
- 첫 읽기 후 5초 이내에 트랜잭션 완료
- 이 제약 덕분에 100+ TiB 클러스터에서 전체 ACID 트랜잭션 가능

### 결정론적 시뮬레이션 테스팅

FoundationDB는 [[결정론적 시뮬레이션 테스팅]]의 선구자다. 이 접근을 [[TigerBeetle]]과 Antithesis(전 FoundationDB 멤버 설립)가 이어받았다 (출처: [[7 Databases in 7 Weeks for 2025]]).

### 프로덕션 사용

Apple, Snowflake, Tigris Data가 프로덕션에서 사용한다.

## 관련 링크

- [[결정론적 시뮬레이션 테스팅]] — FoundationDB가 개척한 테스팅 패러다임
- [[TigerBeetle]] — 시뮬레이션 테스팅을 이어받은 금융 특화 DB
- FoundationDB 튜토리얼: https://apple.github.io/foundationdb/tutorials.html
- FoundationDB 논문: https://www.foundationdb.org/files/fdb-paper.pdf
