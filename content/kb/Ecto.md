---
publish: true
created: 2026-04-08T03:35:00Z
modified: 2026-04-08T03:35:00Z
tags:
  - kb
  - glossary
  - elixir
  - ecto
---

Elixir 생태계의 데이터베이스 래퍼이자 쿼리 생성기. Ruby의 ActiveRecord나 Python의 SQLAlchemy와 비슷한 역할이지만, 설계 철학이 다르다.

## 핵심 특징

- **Schema**: Elixir struct와 DB 테이블을 매핑하는 선언. `schema` 매크로로 정의
- **Changeset**: 데이터 변경을 추적하고 검증하는 구조체. 삽입/수정 전에 반드시 거쳐야 함
- **Query**: SQL을 Elixir 매크로로 작성하는 DSL. 파이프라인(`|>`)으로 조합 가능
- **Repo**: 실제 DB 연결을 담당. `Repo.insert`, `Repo.all` 등

## ActiveRecord와 차이

Ecto는 "데이터와 행동을 분리"하는 철학. 모델 객체에 `save()` 메서드가 없다. 대신 changeset을 만들어서 Repo에 넘긴다. 이 분리 덕분에 DB 없이도 changeset 검증이 가능하고, [[Ecto Embedded Schema]]처럼 DB와 무관한 용도로도 사용할 수 있다.

## 관련 링크

- [[Ecto 커스텀 스키마 모듈]] — Ecto.Schema 래퍼 패턴
- [[Ecto Embedded Schema]] — DB 없는 Ecto 활용
- [[Elixir Struct]] — Ecto schema의 기반인 struct
