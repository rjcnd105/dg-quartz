---
publish: true
created: 2026-04-27T03:33:23Z
modified: 2026-04-27T03:33:23Z
tags:
  - kb
  - llm
  - rag
  - retrieval
  - agent
---

Failure-aware RAG는 retrieval이 실패했을 때 단순히 더 많이 검색하지 않고, 실패의 구조적 원인을 진단한 뒤 query/evidence alignment를 고치는 접근이다. Skill-RAG는 hidden-state prober와 skill router로 이 패턴을 구현한다 (출처: [[Skill-RAG Failure-State-Aware Retrieval Augmentation via Hidden-State Probing and Skill Routing]]).

## 핵심 내용

기존 adaptive RAG는 "검색할지", "몇 번 검색할지"를 주로 다룬다. Skill-RAG는 반복 retrieval 뒤에도 답이 틀리는 hard case 중 상당수가 evidence 부재가 아니라 **query와 evidence space의 misalignment**에서 온다고 본다.

Pipeline:

1. Hidden-state prober가 parametric knowledge만으로 답할 수 있는지 판단한다.
2. 필요하면 standard retrieval을 수행하고 augmented generation 상태를 다시 probe한다.
3. 실패 state로 판단되면 skill router가 실패 원인을 진단한다.
4. Router는 네 가지 skill 중 하나를 선택한다: query rewriting, question decomposition, evidence focusing, exit.
5. 수정된 query로 다음 retrieval round를 수행하고, prober가 termination을 결정한다.

Skill vocabulary가 작다는 점이 중요하다. 논문은 auto-generated six-plus skill set이 failure representation geometry를 흐트러뜨렸다고 보고한다. 즉, recovery action은 많을수록 좋은 것이 아니라 failure state의 실제 구조와 맞아야 한다.

## Skill taxonomy

| Skill | 적용 실패 |
|------|-----------|
| Query rewriting | 질문 표면형이 corpus indexing convention과 어긋남 |
| Question decomposition | multi-hop query의 premise가 얽혀 있음 |
| Evidence focusing | broad query가 필요한 evidence slot을 못 좁힘 |
| Exit | retriever limitation, missing knowledge, model capacity 한계 |

## 실무 함의

- Retrieval failure retry는 기본값이 아니라 마지막 수단이어야 한다.
- "검색 결과가 나쁘다"와 "현재 query가 evidence space에 맞지 않는다"를 분리해야 한다.
- Recovery skill이 많아지면 routing이 좋아지는 것이 아니라, failure taxonomy가 흐려질 수 있다.

## 관련 링크

- [[Agent Memory Systems]] — RAG가 agent memory에서 실패하는 노이즈/attention dilution 문제
- [[Memory Transfer Learning]] — domain routing과 step-wise retrieval 필요성
- [[LLM Harness]] — retrieval을 포함한 모델 주변 시스템 설계
