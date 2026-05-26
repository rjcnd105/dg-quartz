---
publish: true
created: 2026-04-08T03:20:00Z
modified: 2026-04-08T03:20:00Z
tags:
  - kb
  - glossary
---

Multi-Version Concurrency Control. 데이터베이스에서 여러 트랜잭션이 동시에 실행될 때 lock 없이 일관성을 유지하는 동시성 제어 기법이다.

## 핵심 원리

MVCC에서는 데이터를 수정할 때 기존 행을 덮어쓰지 않고 **새 버전**을 생성한다. 각 트랜잭션은 시작 시점의 스냅샷을 보기 때문에, 읽기 작업이 쓰기 작업을 차단하지 않는다. 이 덕분에 읽기 성능이 lock 기반 방식보다 훨씬 좋다.

## PostgreSQL의 MVCC

[[PostgreSQL]]은 MVCC를 핵심 동시성 모델로 사용한다. 삭제되거나 업데이트된 행의 이전 버전(dead tuple)이 테이블에 남아 있으므로, 주기적으로 **VACUUM**을 실행하여 이를 정리해야 한다. VACUUM이 지연되면 테이블 크기가 불필요하게 커지고 성능이 저하된다.

## 관련 문서

- [[PostgreSQL]] — MVCC를 동시성 제어 핵심으로 사용
