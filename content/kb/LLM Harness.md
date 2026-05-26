---
publish: true
created: 2026-04-08T03:15:00Z
modified: 2026-05-08T08:30:39Z
tags:
  - kb
  - llm
  - harness
  - system-design
---

LLM 주변의 코드 인프라로, 정보를 저장(store), 검색(retrieve), 제시(present)하는 역할을 한다. 모델 가중치만큼 시스템 성능에 중요한 요소.

## 핵심 내용

Harness는 모델 자체가 아닌, 모델을 둘러싼 코드 인프라를 가리킨다. Prompt 구성, context 선택, 정보 검색, 출력 파싱 등이 모두 harness의 영역이다 (출처: [[Meta-Harness End-to-End Optimization of Model Harnesses]]).

현재 대부분의 LLM 시스템에서 이 harness는 수동으로 엔지니어링된다. 하지만 Meta-Harness 연구는 **harness 코드 자체를 자동 최적화**할 수 있음을 보여준다:

- **Agentic proposer**가 소스 코드, 성능 점수, 실행 트레이스에 filesystem 접근하여 harness 코드를 탐색하고 개선
- Text classification에서 SOTA 대비 **+7.7점**, context 토큰 **75% 절감**
- 수학 추론에서 단일 harness가 IMO급 200문제에서 5개 모델 평균 **+4.7점**
- Agentic coding에서 수동 엔지니어링 baseline 능가

### 핵심 통찰

후보 harness 데이터의 **풍부한 이력 접근**(코드 + 성능 점수 + 실행 트레이스)이 텍스트 기반 최적화(prompt engineering 등)보다 효과적이다. 최적화 대상이 자연어 프롬프트가 아니라 **코드** 자체이므로, 코드의 구조적 속성을 활용할 수 있다.

## 실전 사용

Harness 최적화는 모델 교체 없이 시스템 성능을 개선하는 경로다. 특히:

- 동일 모델에서 context 토큰을 줄이면서 성능을 올릴 수 있다 (비용 절감 + 성능 향상 동시 달성)
- 여러 모델에 걸쳐 일반화되는 harness를 찾을 수 있다 (모델 5개 평균 +4.7점)

## Runtime boundary

[[Managed Agent Architecture]]는 harness를 sandbox와 session에서 분리해, harness 자체도 cattle처럼 restart 가능한 component로 만든다 (출처: [[Scaling Managed Agents Decoupling the brain from the hands]]). 이 관점에서 harness는 model prompt를 꾸미는 code만이 아니라 session event log를 읽고, tool/sandbox를 호출하고, credential boundary를 유지하는 runtime control plane이다.

## 관련 링크

- [[Agent Skill Representation]] — harness가 로드하는 skill artifact를 구조화해 routing/review에 쓰는 표현
- [[Failure-Aware RAG]] — retrieve 단계가 실패했을 때 harness가 retry가 아니라 failure diagnosis와 routing을 수행하는 패턴
- [[Scale-Dependent Verbosity]] — 모델에 제시하는 정보(harness의 역할)가 출력 행동에 미치는 영향의 한 사례
- [[Managed Agent Architecture]] — brain, hands, session을 분리하는 long-horizon agent runtime
- [[Faithful Uncertainty]] — tool use와 retrieval을 조절하는 metacognitive control signal
