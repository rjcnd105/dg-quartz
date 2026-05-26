---
publish: true
created: 2026-04-08T03:15:00Z
modified: 2026-04-08T03:15:00Z
tags:
  - kb
  - database
  - tigerbeetle
  - financial-transactions
  - zig
  - simulation-testing
---

금융 거래 전용 단일 목적 데이터베이스. "강박적으로 정확한(obsessively correct)" 설계로, NASA의 Power of Ten Rules부터 Direct I/O까지 적용한다.

## 핵심 내용

### 단일 목적 설계

범용 데이터베이스가 아니라 전적으로 금융 거래(financial transactions)에 특화되어 있다. 단일 목적 데이터베이스는 드문 편이며, 오픈소스인 점이 더욱 이례적이다 (출처: [[7 Databases in 7 Weeks for 2025]]).

### 안전성 접근

극단적 수준의 정확성을 추구한다 (출처: [[7 Databases in 7 Weeks for 2025]]):

- **NASA Power of Ten Rules** — 안전 관건 코드 개발 규칙 적용
- **Protocol-Aware Recovery** — 프로토콜을 인식하는 복구
- **Strict Serialisability** — 엄격한 직렬화 가능성
- **Direct I/O** — 커널 페이지 캐시 문제 회피
- **Tiger Style** — TigerBeetle 고유의 프로그래밍 접근 방식

### 결정론적 시뮬레이션 테스팅

[[FoundationDB]]에서 시작된 [[결정론적 시뮬레이션 테스팅]]을 채택했다. VOPR(Viewstamped Operation Replayer)로 불리는 자체 테스팅 프레임워크를 사용한다 (출처: [[7 Databases in 7 Weeks for 2025]]).

### Zig 언어

시스템 프로그래밍 언어 Zig로 작성되었다. 비교적 새로운 언어지만 TigerBeetle의 정확성 목표와 잘 부합한다.

## 실전 사용

범용 DB([[PostgreSQL]] 등)와 함께 사용하는 것이 권장된다. 일반 데이터는 범용 DB에, 금융 거래 데이터만 TigerBeetle에 저장하는 아키텍처.

## 관련 링크

- [[결정론적 시뮬레이션 테스팅]] — FoundationDB에서 시작된 테스팅 패러다임
- [[FoundationDB]] — 시뮬레이션 테스팅의 선구자
- TigerBeetle 공식: https://tigerbeetle.com/
- Tiger Style: https://github.com/tigerbeetle/tigerbeetle/blob/main/docs/TIGER\_STYLE.md
