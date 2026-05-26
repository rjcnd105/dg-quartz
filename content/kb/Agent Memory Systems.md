---
publish: true
created: 2026-04-17T08:00:00Z
modified: 2026-05-18T06:34:02Z
tags:
  - kb
  - llm
  - agent
  - memory
  - architecture
---

LLM 에이전트가 과거 trajectory·결과·실패를 어떻게 저장·검색·활용하는가의 설계 공간. Long-context, RAG, guidance abstraction, 파라메트릭 내재화 네 갈래.

## 핵심 내용

Deep Research Agent(DRA)가 multi-turn 추론+도구 호출을 반복하면서 과거 경험을 재사용하려면 메모리 시스템이 필요하다. [[Memory Intelligence Agent (MIA)]] 저자들은 기존 접근을 다음과 같이 분류한다 (출처: [[Memory Intelligence Agent]]).

### 유형 분류

| 유형 | 저장 방식 | 대표 시스템 | 한계 |
|------|----------|------------|------|
| Long-context | 전체 trace를 컨텍스트에 누적 | 기본 장문 context agent | attention dilution, 노이즈, 비용 |
| Retrieval-augmented | 원본/trace를 인덱스하여 RAG | RAG, Mem0, A-Mem | "No Memory"보다 못한 경우 다수 관찰 |
| Meta-guidance | trace를 high-level 규칙/경험으로 추상화 | ReasoningBank, ExpeL, Memento | 추상화 품질이 Planner 능력에 의존 |
| Parametric | trace를 모델 가중치로 내재화 | Memory-r1, Memento(부분), MIA | 실시간 업데이트 난이도 |

### Knowledge-oriented vs Process-oriented

Deep research는 "무엇이 답인가"(fact)보다 **"어떻게 답에 도달했는가"** (search trajectory, 실패 시도, 성공 전략)가 중요하다. 전통 RAG는 전자를 최적화하므로 DRA에 부적합. Process-oriented 메모리가 필요하다는 주장.

### 검색 축의 다양성

대부분 시스템은 **semantic similarity** 단일 축만 사용. 저자들은 다음 3축을 제안:

- **Semantic similarity** — 현재 질문과 과거 질문의 의미적 유사도
- **Value reward** — 과거 trajectory의 성공률/품질. 고품질 컨텍스트만 노출.
- **Frequency reward** — 저빈도 trajectory를 우대하여 long-tail 탐색 장려.

1축 검색은 "비슷한 성공 사례만 반복 제시" → over-exploitation. 3축 조합이 exploration-exploitation 균형에 유리.

### Positive + Negative Paradigm

성공 trajectory만 저장하지 않는다. **실패 사례도 함께 저장**하여 Planner가 "이 경로는 피해야 한다"는 부정 prior를 가질 수 있게 한다. positive는 최단 성공, negative는 랜덤 실패 샘플.

### Long-context가 왜 실패하는가

저자 실험에서 RAG/Mem0/A-Mem 류는 "No Memory" baseline보다 평균적으로 성능이 낮다. 원인:

1. 컨텍스트가 길어질수록 현재 질문 이해가 희석
2. 약한 관련 메모리가 노이즈로 작용
3. 컨텍스트 누적 시 저장·검색 비용 증가
4. Executor에 메모리를 직접 주입하면 plan 품질과 무관하게 혼란

> [!info] 톤
> 이 페이지의 분류와 결론은 MIA 논문이 제시한 관점. 객관적 survey가 아니라 MIA의 이론적 배경이라는 점을 감안. 독립 출처가 추가되면 확정 톤으로 전환.

## 설계 원칙 (논문 제안)

- 메모리는 **Planner의 prior**로만 쓰고, Executor에는 plan만 넘긴다. Executor가 raw memory를 직접 보면 노이즈 ↑.
- 검색은 **다축** 점수로. 단일 similarity는 exploitation으로 치우침.
- 비파라메트릭(즉시 수정 가능) + 파라메트릭(압축·내재화) **병렬** 구조가 저장 폭발을 막는다.
- 실패 trajectory를 버리지 말 것. 부정 학습 신호.

## Memory Format 추상화 축

Kim et al. (2026-04)이 coding agent 맥락에서 4가지 memory format 체계화 (출처: [[Memory Transfer Learning How Memories are Transferred Across Domains in Coding Agents]]).

| Format | 구조 | 추상화 | 전이성 |
|--------|------|--------|--------|
| Trajectory | (task, \[(action, obs)]) | 최저 | 낮음 (brittle anchor) |
| Workflow | (goal, \[meaningful actions]) | 중 | 중 |
| Summary | (task 요약, 분석 문단) | 중상 | 높음 |
| Insight | (title, description, content) | 최고 | **최고** |

### Abstraction dictates Transferability

> [!info] 갱신 (2026-04)
> MIA 논문의 "meta-guidance vs raw trajectory" 구분이 cross-domain 실험으로 정량 검증. 평균 +3.7%, Insight format이 모든 포맷 중 최고 transferability. 동일 format(Insight) 내에서도 task-agnostic 30%가 task-specific 30%보다 +1.1% 우위. 즉 **format보다 abstraction 자체가 지배 변수**.

### Negative Transfer 3모드

cross-domain 이식 실패 패턴:

1. **Domain-mismatched anchoring** — 표면 유사 memory가 잘못된 anchor로 작동
2. **False validation confidence** — verification memory로 거짓 확신 → self-confirming loop
3. **Misapplied best-practice transfer** — 성공 패턴 무차별 적용, task semantic 침해 (예: R routine을 C++에)

원인은 **retrieval 실패 + adaptation 실패** 두 축. Trajectory 저장을 피하고 Insight 중심으로 쌓는 것이 근본 방어.

Cross-model 전이 가능 (model-agnostic meta-knowledge) 하지만 self-generated보다 열세. Embedding similarity가 LLM reranking·rewriting보다 실제로 우위 — 동적 agent 설정에서 필요 knowledge 예측 어려움.

## World Knowledge as Environment Memory

[[Native Agent Evolution]]은 task trajectory가 아니라 **environment instance 자체**를 압축한 Markdown guidebook을 external memory로 사용한다 (출처: [[Training LLM Agents for Spontaneous, Reward-Free Self-Evolution via World Knowledge Exploration]]). 이는 process-oriented memory와 knowledge-oriented memory의 중간에 있다. 저장 대상은 "이 task를 어떻게 풀었나"가 아니라 "이 website/game/repository가 어떻게 구성되어 있나"이며, downstream task가 나중에 주어질 때 context module로 재사용된다.

위험은 memory transfer의 negative mode와 같다. 잘못 압축된 world knowledge는 agent가 환경을 다시 탐색하지 않고 오래된 guidebook에 고정되는 anchor bias를 만들 수 있다.

## Memory as versioned resource

[[Autogenesis Protocol]]은 memory를 prompt/tool/agent/environment와 같은 first-class RSPL resource로 둔다 (출처: [[Untitled]]). 이는 memory를 단순 vector store나 context chunk가 아니라 lifecycle, version lineage, rollback 대상이 되는 mutable system component로 보는 관점이다.

실무적으로는 memory update가 곧 production state mutation이므로, 저장 전 evaluation과 rollback path가 필요하다. 특히 agent가 자기 memory를 수정할 수 있으면 false validation confidence나 domain-mismatched anchoring이 누적될 수 있다.

## 관련 링크

- [[Memory Intelligence Agent (MIA)]] — 위 원칙의 구체적 구현
- [[Personalized Research Automation Agents]] — skill bank, memory module, planner policy를 함께 진화시키는 research automation 사례
- [[Memory Transfer Learning]] — 4-format taxonomy와 abstraction-transferability 실증
- [[Test-Time Learning]] — 메모리 업데이트 타이밍의 한 축
- [[LLM Wiki 패턴]] — knowledge-oriented 메모리의 한 형태
- [[Native Agent Evolution]] — reward-free inference에서 world knowledge를 생성·재사용하는 agent evolution 패턴
- [[Autogenesis Protocol]] — memory lifecycle/version lineage를 protocol surface로 올리는 접근
- [[ReAct]] — Executor가 도구와 상호작용하는 기본 루프
- [[File-as-Bus]] — durable artifact 기반 memory의 한 구현
- [[Managed Agent Architecture]] — session log를 context window 밖의 durable context object로 두는 runtime pattern
