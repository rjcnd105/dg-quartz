---
publish: true
created: 2026-04-27T03:33:23Z
modified: 2026-04-27T03:39:39Z
tags:
  - kb
  - llm
  - agent
  - evolution
  - memory
---

Native Agent Evolution은 agent가 task를 받기 전 unknown environment를 자발적으로 탐색하고, 그 결과를 reusable world knowledge로 압축하여 이후 task execution에 사용하는 self-evolution 패러다임이다 (출처: [[Training LLM Agents for Spontaneous, Reward-Free Self-Evolution via World Knowledge Exploration]]).

## 핵심 내용

Zhang et al. (2026)은 기존 self-evolving agent가 실제로는 human-defined task, workflow, reward에 의존한다고 비판한다. 제안된 대안은 two-phase lifecycle이다.

1. **Native Evolution Phase**: agent가 새 environment에 들어가 task 없이 탐색하고 Markdown 형태의 world knowledge를 생성한다.
2. **Knowledge-Enhanced Execution Phase**: downstream task가 주어지면 생성된 world knowledge를 context module로 사용한다.

World knowledge는 일반 skill과 다르다. Skill이 task-specific procedure라면, world knowledge는 특정 environment instance의 "mental map"이다. 예를 들어 ACL 2024 website, 특정 game world, 복잡한 code repository의 구조와 중요 페이지를 요약한 guidebook이 된다.

## Training signal

Inference time에는 reward-free이지만, training time에는 outcome-based reward를 사용한다. Generated world knowledge가 downstream task success rate를 얼마나 올렸는지를 reward로 삼는다.

훈련은 두 단계다.

- **SFT**: Gemini-2.5-Pro teacher가 만든 exploration trajectory와 guidebook 중 downstream utility가 높은 candidate를 선택해 imitation learning.
- **RFT**: policy가 여러 world knowledge candidate를 만들고, downstream utility가 가장 높은 trajectory만 rejection sampling으로 다음 fine-tuning data에 넣는다.

이 구조는 [[Test-Time Learning]]과 다르다. Test-Time Training은 inference 중 weight update가 필요하지만, Native Agent Evolution은 inference 시 Markdown world knowledge를 prompt context로 주입한다. 따라서 high-throughput inference framework와 충돌이 적다.

## Protocol boundary

[[Autogenesis Protocol]]은 "agent가 무엇을 학습했는가"보다 **evolution 가능한 resource의 lifecycle과 rollback**을 다룬다 (출처: [[Untitled]]). Native Agent Evolution이 environment mental map을 만들어 task execution을 보조한다면, Autogenesis는 prompt, tool, memory, environment 자체를 protocol-registered resource로 만들고 update/restore를 표준화한다.

## 결과와 한계

논문은 WebWalker와 WebVoyager subset 1,427 query에서 Qwen3-30B와 Seed-OSS-36B에 약 20% absolute improvement를 보고한다. Qwen3-14B가 generated world knowledge를 사용할 때 unassisted Gemini-2.5-Flash를 넘는 cross-model transfer도 보고했다.

단일 출처 기준으로는 다음 한계가 남는다.

- Web navigation 중심 평가라 codebase, desktop app, long-running engineering task로의 일반화는 미검증이다.
- Reward-free inference는 training-time downstream labels와 evaluation pipeline에 의존해 학습된 능력이다.
- World knowledge가 오래되거나 잘못 압축되면 execution phase에서 강한 anchor bias가 될 수 있다.

## 관련 링크

- [[Autogenesis Protocol]] — self-evolution을 resource versioning + operator loop로 정식화
- [[Self-Evolving Code]] — repository 자체를 persistent하게 수정하는 evolution. Native Agent Evolution은 environment knowledge를 외부 context로 만든다.
- [[Agent Memory Systems]] — world knowledge는 knowledge-oriented external memory의 한 형태
- [[LLM Wiki 패턴]] — raw source를 persistent wiki로 압축한다는 점에서 world knowledge와 인접
- [[SFT]]
- [[GRPO]]
