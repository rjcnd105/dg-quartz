---
publish: true
created: 2026-05-07T03:10:01Z
modified: 2026-05-07T03:10:01Z
tags:
  - kb
  - llm
  - architecture
  - scaling
---

Mixture of Experts(MoE)는 model capacity와 per-token active compute를 분리하는 neural architecture다. 전체 parameter를 매 input마다 쓰는 dense model과 달리, gating/router가 일부 expert만 선택해 sparse computation을 수행한다 (출처: [[Mixture of Experts (MoE) Scaling AI with Specialized Models]]).

## 핵심 내용

MoE layer는 보통 transformer block의 feed-forward network 위치에 들어간다. Input token은 router/gating network를 거쳐 top-k expert로 보내지고, 선택된 expert output이 weighted aggregation되어 다음 layer로 전달된다.

MoE가 중요한 이유는 scale의 병목을 바꾸기 때문이다.

- Dense model은 parameter count 증가가 대체로 compute 증가로 이어진다.
- MoE는 total parameter count를 키우면서도 token당 active expert 수를 제한한다.
- Expert는 training 중 자연스럽게 일부 pattern이나 domain에 specialize할 수 있다.
- Router는 quality뿐 아니라 load balancing과 communication cost를 동시에 다루는 핵심 component가 된다.

## Load balancing 문제

MoE의 실패 모드는 expert imbalance다. Router가 특정 expert만 과도하게 고르면 overloaded expert와 undertrained expert가 동시에 생긴다. 그래서 large-scale MoE는 auxiliary load-balancing loss, capacity factor, token dropping/dispatch policy 같은 system-level 장치를 둔다. 이 장치가 없으면 "전문가가 많다"는 capacity가 실제 inference/training throughput으로 이어지지 않는다.

## Dense model과 다른 tradeoff

MoE는 FLOPs를 줄이는 대신 memory footprint와 distributed communication을 키운다. Expert가 여러 GPU/host에 흩어지면 all-to-all dispatch 비용이 커지고, serving stack은 router, expert placement, batching, capacity control을 함께 최적화해야 한다. 따라서 MoE는 단순히 "더 싸고 큰 모델"이 아니라, sparse activation을 감당할 infra가 있을 때 유효한 scaling pattern이다.

## 관련 링크

- [[Squeeze Evolve]] — model routing으로 test-time cost를 줄이는 orchestration pattern
- [[AI Organisation]] — specialised worker routing이라는 비슷한 사고를 agent 조직 레이어에 적용
- [[LLM Harness]] — MoE serving에서 routing/dispatch/monitoring을 감싸는 system layer
- 원문: https://x.com/JayanthSanku01/article/2052050827142131787
