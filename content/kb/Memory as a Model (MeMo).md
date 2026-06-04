---
publish: true
created: 2026-05-27T03:07:26Z
modified: 2026-05-27T03:07:26Z
tags:
  - kb
  - llm
  - memory
  - rag
  - architecture
---

Memory as a Model(MeMo)는 새 지식을 vector index나 prompt context가 아니라 별도의 Memory model 파라미터에 압축하고, frozen Executive model이 이를 multi-turn query protocol로 조회하는 knowledge integration 방식이다 (출처: [[MeMo Memory as a Model]]).

## 핵심 내용

MeMo는 knowledge integration을 세 구성요소로 나눈다.

| 구성요소 | 역할 |
|----------|------|
| Generator model | target corpus에서 fact, entity, cross-document relation을 뽑아 reflection QA dataset 생성 |
| Memory model | reflection QA dataset으로 fine-tune되어 corpus knowledge를 파라미터에 내재화 |
| Executive model | 사용자 질문을 sub-query로 분해하고 Memory model 응답을 조합해 최종 답변 생성 |

저자들은 이 방식을 [[RAG]]와 fine-tuning 사이의 중간 지점으로 둔다. RAG처럼 Executive model은 그대로 두지만, 검색 시점마다 raw chunk를 가져오지 않고 Memory model이 응답하는 compact natural-language memory를 사용한다. Fine-tuning처럼 지식은 파라미터에 들어가지만, 주 reasoning model이 아니라 별도 memory artifact가 바뀐다.

## Reflection QA pipeline

MeMo의 training data는 raw corpus를 그대로 학습하는 것이 아니라 reflection QA 쌍으로 변환된다.

1. Raw document chunk에서 direct/indirect fact를 추출한다.
2. 중복·겹침을 consolidate한다.
3. 원문과 대조해 QA를 verify/rewrite/discard한다.
4. entity surfacing으로 핵심 entity를 명시한다.
5. document group 안에서 cross-document QA를 만든다.

이 5단계 중 cross-document synthesis가 핵심이다. 저자들은 이 단계를 제거하면 NarrativeQA와 MuSiQue 성능이 크게 떨어진다고 보고한다.

## RAG와의 차이

MeMo가 겨냥하는 RAG failure mode는 retrieval noise와 cross-document reasoning 병목이다. 논문은 NV-Embed-V2와 HippoRAG2 같은 retrieval baseline이 distractor document가 추가될 때 성능이 떨어지는 반면, MeMo는 비교적 안정적이었다고 주장한다.

실무적으로는 다음 절충이다.

- RAG: 업데이트 쉽고 출처 추적이 선명하지만, 검색 품질·컨텍스트 예산·noise에 민감하다.
- MeMo: inference 시 corpus size와 독립적인 compact query interface를 제공하지만, memory model training 비용과 provenance 손실 위험이 있다.
- Full fine-tuning: model 자체가 지식을 내재화하지만, closed model에는 적용하기 어렵고 catastrophic forgetting 위험이 크다.

## 위험과 한계

MeMo는 "출처 있는 검색"을 "출처가 숨은 model 응답"으로 바꿀 수 있다. 논문 impact statement도 misinformation, unauthorized proprietary data, harmful content를 Memory model에 내재화할 dual-use risk와 provenance 약화를 언급한다.

따라서 운영 환경에서는 Memory model 응답만 저장하지 말고, 학습 corpus manifest, reflection QA 생성 로그, source attribution, removal/rollback path를 함께 관리해야 한다. 지식이 모델 파라미터로 들어가면 단일 문서 삭제처럼 간단히 되돌리기 어렵다.

## 관련 링크

- [[Agent Memory Systems]] — long-context, RAG, meta-guidance, parametric memory의 설계 공간
- [[LLM Wiki 패턴]] — raw source를 사람이 읽을 수 있는 persistent wiki로 컴파일하는 knowledge-oriented memory
- [[Failure-Aware RAG]] — 검색 실패를 query/evidence alignment 문제로 진단하는 접근
- [[Memory Transfer Learning]] — memory format과 abstraction이 transferability를 좌우한다는 실험 축
- [[SFT]] — Memory model training에 쓰이는 supervised fine-tuning
- 원문: https://arxiv.org/html/2605.15156v2
