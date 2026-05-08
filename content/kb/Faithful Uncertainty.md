---
publish: true
created: 2026-05-08T08:30:39Z
modified: 2026-05-08T08:30:39Z
tags:
  - kb
  - llm
  - reliability
  - metacognition
---

Faithful uncertainty는 LLM이 외부 세계의 진실을 완벽히 맞히는 능력이 아니라, 자기 내부 불확실성을 언어적 확신도와 맞추는 metacognitive 능력이다.

## 핵심 내용

Yona, Geva, Matias의 논문은 hallucination을 단순한 "오답"이 아니라 **confident error**로 재정의한다. 이 관점에서는 answer-or-abstain 이분법 대신, 답은 하되 내부 불확실성만큼 적절히 hedge하는 세 번째 경로가 생긴다 (출처: [[Hallucinations Undermine Trust; Metacognition is a Way Forward]]).

논문의 구분은 다음이다.

- **Calibration**: confidence bucket의 평균 정답률이 맞는가.
- **Discrimination**: 개별 답변에서 맞는 답과 틀린 답을 confidence로 구분할 수 있는가.
- **Intrinsic uncertainty**: 같은 질문을 반복 sample했을 때 의미상 충돌하는 답이 얼마나 나오는가.
- **Linguistic uncertainty**: 모델이 문장 속에서 얼마나 단정적으로 말하는가.

Calibration이 좋아도 discrimination이 낮으면, hallucination을 줄이려면 많은 정답까지 거절해야 한다. 저자들은 이를 utility tax라고 부른다. Faithful uncertainty는 외부 truth를 완벽히 알아내려 하지 않고, 모델 내부 confidence를 언어적 decisiveness에 맞추는 문제로 바꾼다.

## Agent control layer

Agentic system에서는 faithful uncertainty가 단순한 말투 문제가 아니라 tool-use control layer가 된다. 모델이 "내가 아는지 모르는지"를 모르면, 검색을 과하게 쓰거나 필요한 검색을 놓칠 수 있다. Retrieved evidence가 internal prior와 충돌할 때도, uncertainty signal이 없으면 어느 쪽을 신뢰할지 판단하기 어렵다.

따라서 [[Managed Agent Architecture]]나 [[LLM Harness]]에서 metacognition은 retrieval, verification, halt, handoff를 결정하는 control signal로 볼 수 있다.

## 해석 경계

Faithful uncertainty는 factuality 연구를 대체하지 않는다. 모델의 knowledge boundary를 넓히는 일과, 남은 boundary를 정직하게 표현하는 일은 별개다. 또한 무조건 hedge하는 모델은 faithful하지 않다. 핵심은 모든 답에 의심을 붙이는 것이 아니라 answer별 intrinsic uncertainty와 linguistic uncertainty를 맞추는 것이다.

## 관련 링크

- [[LLM Harness]] — uncertainty를 tool routing과 verification에 반영하는 위치
- [[Failure-Aware RAG]] — retrieval failure를 더 많은 검색이 아니라 실패 형태 진단으로 다루는 패턴
- [[Agent Task Verification]] — agent 자기보고를 외부 postcondition으로 검증하는 reliability pattern
- [[Managed Agent Architecture]] — session/tool/harness boundary가 uncertainty control과 만나는 agent runtime 구조
