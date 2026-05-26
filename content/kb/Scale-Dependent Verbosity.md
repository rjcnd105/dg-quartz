---
publish: true
created: 2026-04-08T03:15:00Z
modified: 2026-04-23T00:00:00Z
tags:
  - kb
  - llm
  - scaling
  - evaluation
  - prompt-engineering
---

큰 LLM이 과도하게 설명(over-elaborate)하면서 오류를 도입하는 현상. 파라미터가 많을수록 장황해지며, 이것이 벤치마크에서 작은 모델보다 낮은 성능으로 이어지는 inverse scaling의 한 원인이 된다.

## 핵심 내용

31개 모델(0.5B~405B) × 1,485문제에 걸친 체계적 평가에서 발견된 현상이다 (출처: [[Brevity Constraints Reverse Performance Hierarchies in Language Models]]):

- \*\*벤치마크 7.7%\*\*에서 큰 모델(10~100x 파라미터)이 작은 모델보다 **28.4pp 낮은** 성능
- 원인은 **scale-dependent verbosity**: 큰 모델이 불필요하게 상세한 설명을 생성하며 그 과정에서 오류를 도입
- 이것은 근본적 능력 한계가 아니라 **교정 가능한 prompt design 문제**

### Brevity Constraint의 효과

간결한 응답을 요구하는 제약을 추가하면:

- 정확도 **+26pp** 향상
- 성능 격차 최대 **2/3 감소**
- 수학/과학 벤치마크에서 성능 위계가 **완전 역전**: 큰 모델이 +7.7~15.9pp 우위

### 실용적 함의

**Scale-aware prompt engineering**이 필요하다:

- 큰 모델에는 brevity constraint가 정확도를 높인다
- Universal evaluation(모든 모델에 같은 프롬프트)은 큰 모델의 능력을 과소평가할 수 있다
- 정확도 향상과 연산 비용 절감을 동시에 달성 — 짧은 출력은 더 적은 토큰을 소비한다

## 관련 링크

- [[Simple Self-Distillation]] — LLM 디코딩 행동 개선의 또 다른 접근: 자체 출력으로 토큰 분포를 재형성
- [[LLM Harness]] — 모델에 정보를 제시하는 방식(harness)이 출력 행동에 영향을 주는 관점에서 관련
- [[Over-Editing]] — 코드 영역의 대응 현상. GPT-5/GPT-5.4가 여기서도 최악 over-editor. Brevity 지시가 Levenshtein 감소와 Pass@1 동시 향상을 낳는 구조 공유
