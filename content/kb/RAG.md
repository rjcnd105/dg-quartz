---
publish: true
created: 2026-05-27T03:07:26Z
modified: 2026-05-27T03:07:26Z
tags:
  - kb
  - glossary
  - llm
  - retrieval
---

RAG(Retrieval-Augmented Generation)는 모델이 답변을 만들기 전에 외부 문서 저장소에서 관련 자료를 검색하고, 검색 결과를 컨텍스트로 넣어 생성하는 패턴이다.

## 핵심 내용

RAG는 모델 가중치를 바꾸지 않고 새 지식을 연결할 수 있다는 장점이 있다. 문서 추가·삭제가 쉽고, 검색된 chunk를 통해 출처를 추적할 수 있다. 대신 검색 query, chunking, ranking, context packing이 실패하면 모델은 중요한 근거를 못 보거나, 관련 없어 보이는 noise에 끌릴 수 있다.

## 관련 링크

- [[Failure-Aware RAG]] — RAG 실패를 더 많은 검색이 아니라 query/evidence alignment 문제로 진단하는 접근
- [[LLM Wiki 패턴]] — 매 쿼리마다 raw source를 재조합하지 않고 위키로 컴파일하는 대안
- [[Memory as a Model (MeMo)]] — 검색 index 대신 별도 Memory model에 corpus knowledge를 압축하는 접근
