---
publish: true
created: 2026-04-29T04:54:11Z
modified: 2026-04-29T04:54:11Z
tags:
  - kb
  - llm
  - agent
  - multi-agent
  - architecture
---

AI organisation은 multi-agent system을 fixed team이나 message graph가 아니라 **agent workforce를 조립·관리·진화시키는 조직 레이어**로 보는 접근이다. OneManCompany(OMC) 논문은 이 레이어를 "skills가 아니라 talents를 운영하는 회사"로 모델링한다 (출처: [[From Skills to Talent Organising Heterogeneous Agents as a Real-World Company]]).

## 핵심 내용

기존 multi-agent framework의 약점은 agent 간 통신 방식보다 **조직 경계 부재**에 있다. 팀 구조가 사전에 고정되거나, agent가 자유 협상하지만 수렴 보장이 약하거나, 모든 agent가 같은 runtime 안에 묶이는 문제가 반복된다. OMC는 이를 capability layer와 organisation layer를 분리해서 푼다.

OMC에서 핵심 단위는 `Employee = Talent + Container`다.

- **Talent**: role, prompt, working principles, tools, skills, supporting resources를 포함하는 portable agent identity
- **Container**: LangGraph, Claude Code, script process 같은 실행 substrate와 typed organisational interface
- **Employee**: Talent가 Container에 탑재되어 lifecycle과 task assignment를 받는 관리 대상 agent

이 구분은 "agent가 무엇을 할 수 있는가"와 "어디서 어떻게 실행되는가"를 분리한다. 같은 Talent를 다른 runtime에서 실행할 수 있고, 같은 Container에 다른 Talent를 올려 역할을 바꿀 수 있다.

## Skills에서 Talents로

OMC 논문은 skills를 단일 agent 내부의 capability abstraction으로 보고, Talents를 team 운영 단위로 본다. Skill은 tool/function처럼 조합되지만 lifecycle이 약하다. Talent는 role, tool access, prompts, skill bundle, benchmark/provenance까지 묶인 agent package라서 hiring, evaluation, replacement의 대상이 된다.

실무적으로 중요한 차이는 다음이다.

| 축 | Skill | Talent |
|----|-------|--------|
| 재사용 단위 | 기능/도구 | 완성된 agent identity |
| 조합 위치 | 단일 agent 내부 | 조직/team 레벨 |
| 검증 | 예제·문서 중심 | benchmark·community provenance 중심 |
| lifecycle | 불명확 | hire, evaluate, replace |
| 학습 | 개인 agent 성능 개선 | 개인 + 조직 개선 |

> [!info] 톤
> 이 구분은 OMC 논문의 제안이다. 독립적인 multi-agent survey 전체의 합의라기보다, OMC가 기존 skill ecosystem을 조직 레벨로 확장하기 위해 세운 taxonomy로 봐야 한다.

## Typed organisational interfaces

Container는 backend별 API를 직접 노출하지 않고 여섯 가지 interface로 agent-platform interaction을 표준화한다.

| Interface | 책임 |
|-----------|------|
| Execution | task를 backend에 dispatch하고 result/cost를 받음 |
| Task | per-employee queue와 mutual exclusion 관리 |
| Event | 조직 event bus, publish/subscribe |
| Storage | short/medium-term persistent state |
| Context | role, guidance, memory로 execution prompt 조립 |
| Lifecycle | pre-hook/post-hook, validation, guardrail, self-improvement |

이 구조는 [[LLM Harness]]를 multi-agent organisation surface로 확장한 형태에 가깝다. Harness가 model 주변의 store/retrieve/present를 다룬다면, OMC Container는 agent workforce 전체의 execution/task/event/storage/context/lifecycle contract를 다룬다.

## Explore-Execute-Review

OMC의 project execution은 Explore-Execute-Review(E2R) tree search로 표현된다.

1. **Explore**: supervisor가 현재 task를 어떤 subtree로 분해하고 누구에게 배정할지 결정한다.
2. **Execute**: 각 Employee가 자기 task를 Container interface를 통해 수행한다.
3. **Review**: parent/supervisor가 결과를 accept/reject하고, 실패하면 새 decomposition을 탐색한다.

Task graph는 [[DAG]] dependency와 [[Finite State Machine]] lifecycle로 관리된다. 중요한 gate는 `completed -> accepted`가 자동이 아니라 explicit review를 요구한다는 점이다. 이 gate가 없으면 한 agent의 hallucinated completion이 downstream task를 unblock해서 error cascade를 만든다.

## Self-evolution

OMC의 self-evolution은 model retraining이 아니라 **Talent artifact와 organisation SOP의 갱신**이다.

- 개별 agent: CEO one-on-one, post-task reflection으로 working principles/progress log 업데이트
- project: retrospective로 repeated failure와 effective pattern을 SOP로 압축
- 조직 lifecycle: periodic review, PIP, offboarding, re-recruitment로 capability stagnation 방지

이 점에서 [[Self-Evolving Code]]와 방향이 다르다. Self-Evolving Code는 repository나 algorithm artifact를 직접 변경하고 formal verifier로 gate를 건다. AI organisation은 agent identity, SOP, task routing policy 같은 조직 artifact를 변경한다.

## 평가와 한계

OMC 논문은 PRDBench 50개 software-development task에서 84.67% success rate를 보고한다. baseline cost는 공개되지 않아 cost-efficiency 직접 비교는 어렵고, OMC 자체 비용은 총 $345.59, task당 약 $6.91로 보고된다 (출처: [[From Skills to Talent Organising Heterogeneous Agents as a Real-World Company]]).

논문 자체 한계:

- 정량 평가는 PRDBench 중심이고 non-coding benchmark 검증은 부족하다.
- one-on-one, retrospective, performance review 등 self-evolution component의 ablation은 아직 없다.
- multi-agent coordination 비용이 커서 단순 task에는 과하다.
- human-enterprise analogy가 강력한 설계 은유지만, 실제 조직 문제가 그대로 AI agent system에 전이되는지는 추가 검증이 필요하다.

## 관련 링크

- [[LLM Harness]] — agent 실행 주변 인프라를 다루는 하위 개념
- [[Agent Memory Systems]] — OMC의 Storage/Context interface와 연결되는 memory 설계 공간
- [[Agent Task Verification]] — `completed -> accepted` review gate와 같은 "거짓 완료 방지" 패턴
- [[Self-Evolving Code]] — persistent artifact mutation 중심 self-evolution
- [[DAG]] — task dependency graph 표현
- [[Finite State Machine]] — task lifecycle 표현
- 원문: https://arxiv.org/html/2604.22446v1
