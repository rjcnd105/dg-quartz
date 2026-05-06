---
publish: true
created: 2026-05-06T08:44:23Z
modified: 2026-05-06T08:44:23Z
tags:
  - kb
  - llm
  - agent
  - multi-agent
  - reinforcement-learning
  - test-time-scaling
---

RL Conductor는 worker LLM들을 직접 답변자로 쓰는 대신, 작은 LLM이 natural language workflow를 설계해 subtask, worker assignment, communication topology를 정하는 multi-agent coordination 방식이다 (출처: [[Learning to Orchestrate Agents in Natural Language with the Conductor]]).

## 핵심 내용

Conductor는 사용자 문제를 직접 풀지 않고, worker agent가 실행할 workflow를 출력한다. Workflow step은 세 요소를 가진다.

| Field | 의미 |
|-------|------|
| `subtasks` | worker가 수행할 natural language instruction |
| `model_id` | 해당 subtask를 맡을 worker |
| `access_list` | 이전 step output 중 worker context에 넣을 항목 |

이 표현은 fixed graph나 hand-written team template보다 유연하다. Conductor는 task difficulty와 worker 특성에 따라 sequential chain, independent attempts, verification round, debate-like topology를 구성할 수 있다.

## 학습 방식

논문은 Conductor를 end-to-end reinforcement learning으로 훈련한다. Reward는 두 gate로 구성된다.

1. format condition: `subtasks`, `model_id`, `access_list`가 parse 가능한지
2. correctness condition: workflow 실행 결과가 정답과 맞는지

이 구조는 [[GRPO]] 같은 grouped rollout 기반 RL에 잘 맞는다. Conductor output 자체가 executable workflow spec이므로, reward는 "좋은 plan을 썼는가"가 아니라 "그 plan을 실행했을 때 정답이 나오는가"에 묶인다.

## 확장

논문은 두 가지 확장을 제시한다.

- **Adaptive worker pool**: 훈련 중 worker subset을 randomize해, 사용 가능한 open/closed model 조합이 바뀌어도 coordination을 재구성하게 한다.
- **Recursive topology**: Conductor가 자기 자신을 worker로 호출해, 초기 workflow를 관찰 후 다시 조정하는 test-time scaling axis를 만든다.

이 접근은 [[AI Organisation]]과 인접하지만 초점이 다르다. AI organisation은 agent identity, lifecycle, storage, task queue 같은 운영 layer를 모델링한다. RL Conductor는 주어진 worker pool 위에서 problem-specific collaboration topology를 학습한다.

## 한계

Conductor는 worker 호출 비용을 coordination으로 바꾸는 방식이다. 쉬운 task에서는 overhead가 낭비될 수 있고, reward가 있는 benchmark에서는 잘 학습되더라도 open-ended task에서는 correctness reward 설계가 어려워진다. Recursive topology는 성능을 올릴 수 있지만 비용과 latency가 늘고, recursion depth 제한이 없으면 control 문제가 생긴다.

## 관련 링크

- [[AI Organisation]] — agent workforce 운영 layer
- [[LLM Harness]] — workflow execution을 실제로 담당하는 runtime
- [[Heavy Thinking]] — parallel reasoning 후 deliberation하는 단순화된 coordination pattern
- [[GRPO]] — grouped rollout reward로 policy를 최적화하는 방법
- [[Test-Time Learning]] — inference-time compute 확장의 넓은 범주
