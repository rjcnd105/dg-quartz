---
publish: true
created: 2026-04-22T00:00:00Z
modified: 2026-04-27T03:39:39Z
tags:
  - kb
  - llm
  - agent
  - evolution
  - code-generation
  - eda
---

LLM 에이전트가 **전체 코드베이스**를 자율적으로 진화시키는 패러다임. generate → compile → formal-verify → benchmark → feedback 루프. AlphaEvolve(100s LoC) → SATLUTION(10k LoC) → Self-Evolved ABC(**1.2M LoC**)로 스케일 확장.

## 핵심 내용

Yu & Ren (2026-04)에 따르면 self-evolving framework는 human-driven 개발의 saturation을 LLM agent가 돌파하는 새 패러다임이다 (출처: [[Autonomous Evolution of EDA Tools Multi-Agent Self-Evolved ABC]]).

핵심 루프:

```
Plan → Code 수정 → Compile → Formal Verify → Benchmark → Feedback
 ↑                                                              │
 └──────────────────────────────────────────────────────────────┘
```

### 스케일 계층

| 프레임워크 | 대상 | 규모 | 분야 |
|-----------|------|------|------|
| AlphaEvolve (DeepMind 2025) | 알고리즘 kernel | 100s LoC | matrix multiplication 등 |
| SATLUTION (NVIDIA 2025) | SAT solver repo | 10k LoC | SAT 경진대회 우승 초과 |
| **Self-Evolved ABC** (2026-04) | EDA logic synthesis tool | **1.2M LoC / 4000 files** | logic synthesis + mapping |

ABC는 직전 scale보다 100배 규모. 단일 objective(SAT=runtime, matmul=FLOPs)가 아닌 **multi-objective** (area, delay, QoR trade-off)까지 확장.

### Formal Correctness Gate가 핵심

모든 반복마다 modification 직후 **formal verification**으로 semantic 등가 확인. Self-Evolved ABC는 CEC(Combinational Equivalence Checking)로 수정 전후 회로 등가 입증 후에만 QoR 평가 진행.

효과:

- 잘못된 rewrite가 evaluator를 속이는 **false improvement 차단**
- 잘못된 variant에 LLM 사이클·compute 낭비 방지 (SATLUTION 교훈)
- **>90% 토큰이 semantically valid state에 소비**

SATLUTION은 DRAT proof(UNSAT 증명 validation), ABC는 CEC(`cec`, `dsat` ABC 명령). 공통 패턴: **대상 domain의 formal verifier를 evolutionary loop 안에 edge로 삽입**.

### Multi-Agent 서브시스템 분해

Self-Evolved ABC가 1.2M LoC를 다루는 방식: 단일 모노리식 agent 대신 **non-overlapping 디렉토리 소유권** 부여.

```
Planning Agent (Claude Sonnet 4.5)
├─ Flow Agent       → src/opt/flowtune/
├─ Mapper Agent     → src/map/mapper/
└─ Logic Min Agent  → src/base/abci/
```

각 coding agent는 지정 디렉토리 안에서만 수정. Planning agent가 global QoR feedback 해석, 다음 사이클 subsystem 결정, subsystem 간 hypothesis 통합.

→ [[AiScientist]]의 Tier-0/Tier-1 분리와 유사하나 여기는 **코드베이스 디렉토리 경계**로 isolation 구현.

### Self-Evolving Rulebase

Planner가 rule 자체를 진화시킴. Rule이 지속적으로 유익한 edit을 block하면 planner가 **controlled relaxation** 제안. 초기 사이클 보수적 → 후기 explorative로 자연스럽게 이행.

### Knowledge Bootstrapping

Cycle 0에 codebase profiling 투입. Self-Evolved ABC에서 **68% 토큰이 초기 profiling**, 11% 외부 codebase 분석, **21%만 evolution cycle 자체**. 한번 priming되면 marginal cost 낮음.

포맷 insight: natural language 대신 **구조화 Markdown tutorial** 제공 시 agent 신뢰도 상승. 절차적 추론 유도, hallucination 감소.

### 결과 (Self-Evolved ABC)

- 전체 QoR **8.3% 개선** (baseline 1.000 → 0.917, lower better)
- Worst negative slack 8-9% 개선
- AIG node count 3-8% 감소, post-mapping depth 4-6% 감소
- 총 비용 ~**$2,400** (profiling $1,400 포함)
- 사이클 당 2-3시간 (87-node AMD EPYC cluster, 8 flows 병렬)

### 한계: 증폭 >> 발명

Agent가 **native coding style에 자발적으로 수렴** (ABC formatting, naming, macro convention). 그러나 anchor 없는 **전혀 새로운 알고리즘 구성**은 실패율 높음 — 컴파일 에러, segfault, 미묘한 correctness 위반.

결론: self-evolving framework는 "**human-curated prior를 증폭·재조합**"하는 데 탁월, **fully novel paradigm 제안**에는 부족. Scaffold가 없는 영역은 아직 agent 혼자 돌파 어려움.

저자 입장 (출처: 결론부): "The success of agents on EDA problems is not created in isolation. It is enabled by decades of foundational contributions from the EDA community." — 진화는 prior 위에서만 잘 작동.

### Protocol layer로의 일반화

[[Autogenesis Protocol]]은 self-evolving code/tool/prompt를 ad hoc loop가 아니라 resource lifecycle protocol로 정식화한다 (출처: [[Untitled]]). Prompt, tool source, memory, environment를 versioned resource로 올리고, Reflect → Select → Improve → Evaluate → Commit operator를 통해 변경을 적용한다. 이 관점에서 Self-Evolved ABC의 formal verification gate는 Autogenesis의 Evaluate/Commit 단계에 해당한다.

## 관련 링크

- [[Autogenesis Protocol]] — prompt/tool/memory/environment를 versioned resource로 관리하는 self-evolution protocol
- [[AI Organisation]] — OMC는 code artifact가 아니라 Talent, SOP, task routing 같은 조직 artifact를 진화시킨다
- [[Native Agent Evolution]] — task 없이 environment를 먼저 탐색하고 world knowledge를 만든다. Self-Evolving Code가 persistent repo mutation이라면, Native Agent Evolution은 external context를 만들어 execution을 보조한다
- [[Squeeze Evolve]] — test-time scaling evolution. Self-Evolving Code는 persistent repo 수정, Squeeze Evolve는 한 프롬프트 답변 생성 — scale·persistence 축이 다름
- [[Autoreason]] — self-refinement (A/B/AB Borda). Self-Evolving Code의 per-cycle rewrite와 유사한 검증 구조, 더 작은 단위
- [[AiScientist]] — Multi-agent orchestration + File-as-Bus. Self-Evolving Code는 File-as-Bus 대신 **디렉토리 ownership**으로 isolation
- [[Agent Task Verification]] — Witness oath도 formal post-condition 검증. CEC gate와 같은 "거짓 완료 방지" 패턴
- 원문: https://arxiv.org/html/2604.15082v1
