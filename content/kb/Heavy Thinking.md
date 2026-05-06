---
publish: true
created: 2026-05-06T08:44:23Z
modified: 2026-05-06T08:44:23Z
tags:
  - kb
  - llm
  - agent
  - reasoning
  - test-time-scaling
---

Heavy thinking은 여러 독립 reasoning trajectory를 만든 뒤 별도 deliberation 단계에서 비교·종합하는 test-time scaling pattern이다. HeavySkill 논문은 이 패턴을 agentic harness 바깥의 복잡한 scaffolding이 아니라 model 내부에서 실행 가능한 "inner skill"로 해석한다 (출처: [[HeavySkill Heavy Thinking as the Inner Skill in Agentic Harness]]).

## 핵심 내용

Heavy thinking의 기본 구조는 두 단계다.

1. **Parallel reasoning**: 같은 문제에 대해 여러 independent trajectory를 생성한다.
2. **Sequential deliberation**: 생성된 trajectory를 serialized memory cache로 묶고, 별도 generation이 이를 비교·검증·재추론해 최종 답을 만든다.

이 구조는 단순 majority vote와 다르다. Vote는 가장 자주 나온 answer를 고르는 반면, deliberation은 reasoning path 자체를 읽고 서로의 오류와 강점을 비교한다. 논문은 이 과정에서 model이 low-frequency correct trajectory를 선택하거나, 모든 trajectory가 틀렸을 때 다시 유도할 수 있다고 본다.

## Skill 형태

HeavySkill은 heavy thinking workflow를 Python orchestration pipeline이 아니라 readable skill document로 distill한다. Skill 문서는 다음을 포함한다.

- activation condition: 복잡한 reasoning task에서만 켜고 simple factual query에는 비용을 쓰지 않음
- parallel reasoning protocol: 여러 independent agent가 서로의 output 없이 문제를 풂
- deliberation prompt: 각 reasoning을 비판적으로 평가하고 필요하면 재유도
- output constraint: meta-analysis가 아니라 target domain의 최종 answer만 반환

이 해석에서 skill은 code dependency가 아니라 harness가 읽는 procedural instruction이다. 충분한 orchestration capability가 있으면 Claude Code나 custom harness 같은 서로 다른 runtime에서 같은 skill text를 실행할 수 있다는 주장이다.

## 성능과 trade-off

논문은 STEM, coding, general reasoning task에서 heavy thinking이 single reasoning과 voting보다 강한 경우를 보고한다. 특히 강한 model에서는 heavy thinking 결과가 Pass@K upper bound에 접근할 수 있다고 주장한다.

하지만 비용과 noise trade-off가 있다. Parallel trajectory 수를 늘리면 성공 후보가 늘지만 context 길이와 summarization 부담도 늘어난다. Iterative deliberation은 평균 성능을 올릴 수 있으나, 이전 summary가 다음 단계에 누적되면서 noise와 bias를 만들 수 있다.

## 관련 링크

- [[Test-Time Learning]] — inference-time compute와 learning/update의 넓은 설계 공간
- [[Agent Memory Systems]] — serialized memory cache와 trajectory abstraction
- [[GRPO]] — heavy-mode-aware RLVR와 인접한 rollout 기반 optimization
- [[LLM Harness]] — skill을 실행하고 subagent call을 배치하는 runtime layer
