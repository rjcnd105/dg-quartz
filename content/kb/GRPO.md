---
publish: true
created: 2026-04-17T08:00:00Z
modified: 2026-04-17T08:00:00Z
tags:
  - kb
  - llm
  - reinforcement-learning
  - glossary
---

Group Relative Policy Optimization. 한 샘플에 대해 여러 rollout을 그룹으로 생성하고, 그룹 내 상대 보상으로 advantage를 계산하여 정책을 최적화하는 PPO 변형.

## 핵심 내용

PPO와 달리 별도의 critic/value 네트워크를 요구하지 않는다. 그룹 내 평균·표준편차로 정규화한 상대 보상을 advantage로 사용:

$$
\hat{A}\_i = \frac{R\_i - \mu\_R}{\sigma\_R + \epsilon}
$$

Clipped policy ratio와 KL 정규화 항을 결합한 objective는 PPO와 유사하다. LLM agent 훈련에서 한 질문에 대해 G개 응답을 샘플링하고 각각의 품질로 서로를 랭킹하는 setting에 잘 맞는다.

DeepSeekMath(Shao et al., 2024)에서 제안. [[Memory Intelligence Agent (MIA)]]가 Planner·Executor alternating RL의 기반으로 사용한다 (출처: [[Memory Intelligence Agent]]).

## 관련 링크

- [[Memory Intelligence Agent (MIA)]] — alternating GRPO로 Planner/Executor 훈련
- [[Test-Time Learning]] — 배포 중 파라미터 업데이트에도 GRPO 활용
- 원 논문: Shao et al., "DeepSeekMath: Pushing the Limits of Mathematical Reasoning in Open Language Models" (2024)
