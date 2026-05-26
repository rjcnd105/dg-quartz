---
publish: true
created: 2026-04-27T03:39:39Z
modified: 2026-04-27T03:39:39Z
tags:
  - kb
  - llm
  - agent
  - protocol
  - evolution
---

Autogenesis Protocol (AGP)은 self-evolving agent에서 prompt, agent, tool, environment, memory를 versioned resource로 등록하고, 변경 제안-검증-commit-rollback 루프를 protocol layer로 분리하려는 제안이다 (출처: [[Untitled]]).

## 핵심 내용

Zhang et al. (2026)은 MCP와 A2A가 connectivity protocol로는 유용하지만 self-evolution에는 부족하다고 본다. MCP는 model-tool invocation, A2A는 inter-agent communication을 표준화하지만, self-evolving system의 핵심인 **state mutation, lifecycle, version lineage, rollback**을 직접 다루지 않는다.

AGP는 두 layer로 나뉜다.

### RSPL: Resource Substrate Protocol Layer

RSPL은 무엇이 진화 가능한지를 정의한다. 논문은 다섯 entity를 minimal substrate로 둔다.

| Resource | 의미 |
|----------|------|
| Prompt | instruction, system prompt, task prompt |
| Agent | decision policy 또는 agent instance |
| Tool | native script, MCP tool, agent skill |
| Environment | task/world dynamics |
| Memory | persistent state와 agent outputs |

각 resource는 name, description, input-output mapping, trainable marker, metadata를 가진 protocol-registered resource가 된다. Context manager는 resource registry와 version history를 관리하고, server interface는 `list`, `get_state`, `update`, `restore`, `run`, `save_to_json` 같은 안정된 operation surface를 제공한다.

핵심은 resource가 passive하다는 점이다. Prompt, tool, memory는 스스로 최적화하지 않고, 상위 evolution layer가 interface를 통해서만 state transition을 수행한다.

### SEPL: Self-Evolution Protocol Layer

SEPL은 어떻게 진화할지를 정의한다. 논문은 evolution을 typed operator algebra로 모델링한다.

| Operator | 역할 |
|----------|------|
| Reflect | execution trace에서 failure hypothesis 생성 |
| Select | hypothesis를 concrete modification proposal로 변환 |
| Improve | proposal을 RSPL interface로 candidate state에 적용 |
| Evaluate | candidate를 objective와 safety invariant로 평가 |
| Commit | 개선 또는 invariant 보존 시 versioned update, 실패 시 rollback |

이 구조의 목적은 self-evolution을 heuristic prompt rewrite가 아니라 **auditable state transition**으로 만드는 것이다. 모든 update는 versioned lineage를 남기고, 실패한 update는 side effect 없이 rollback된다.

## AGS 구현

Autogenesis System (AGS)은 AGP 위에 만든 multi-agent system이다. Orchestrator가 `plan.md` artifact를 만들고 versioned RSPL resource로 등록한다. Sub-agent들은 bus를 통해 작업을 받고, 필요한 prompt/tool resource를 semantic search로 retrieval하며, 결과와 trace를 shared memory에 쓴다.

Tool generator agent는 적합한 tool이 없으면 새 tool을 생성하고 registry에 versioned resource로 등록한다. 적합한 tool이 있지만 실패하면 reflection으로 source code를 수정하고, 평가를 통과한 변경만 commit한다.

이 점에서 AGS는 [[File-as-Bus]]와 유사하게 durable artifact와 shared state를 중시하지만, AGP는 파일 자체보다 **resource lifecycle/version protocol**을 더 전면에 둔다.

## 실험 결과

논문은 GPQA-Diamond, AIME24/25, GAIA Test, LeetCode 기반 coding benchmark에서 AGS를 평가했다.

- Reasoning benchmark에서는 prompt와 solution evolution을 비교했고, combined prompt+solution evolution이 대체로 가장 좋았다.
- GAIA에서는 tool evolution이 평균 79.07% → 89.04%로 개선됐고, Level 3에서 61.22% → 81.63%로 가장 큰 개선을 보였다.
- LeetCode benchmark에서는 five-language setting에서 self-evolution이 pass rate를 Python3 +10.1%, C++ +17.9%, Java +16.7%, Go +15.9%, Kotlin +26.7% relative로 개선했다고 보고했다.

단일 출처 기준으로는 leaderboard comparison, in-house LeetCode construction, protocol abstraction의 실제 interoperability를 독립 검증할 필요가 있다.

## 실무 함의

- Self-evolving agent에서 중요한 boundary는 "agent가 똑똑한가"보다 **무엇을 mutable resource로 허용할 것인가**다.
- Prompt/tool/memory를 hard-coded internal component로 두면 evolution이 glue code가 되고 audit이 어려워진다.
- Evolution loop에는 최소한 trace, hypothesis, proposal, evaluation, commit/rollback 기록이 필요하다.
- Tool evolution은 특히 long-horizon task에서 static toolkit의 병목을 줄일 수 있지만, 안전한 sandbox와 version rollback이 없으면 위험하다.

## 관련 링크

- [[Self-Evolving Code]] — repository/tool/source code 자체를 수정하는 evolution 계열
- [[Native Agent Evolution]] — task-free environment world knowledge 생성. AGP는 resource mutation protocol에 초점
- [[Agent Memory Systems]] — memory를 first-class versioned resource로 다루는 관점
- [[File-as-Bus]] — durable artifact 기반 multi-agent coordination
- [[Agent Task Verification]] — commit 전 objective/safety invariant 검증과 같은 방향
- 원문 PDF: https://arxiv.org/pdf/2604.15034
- 코드: https://github.com/DVampire/Autogenesis
