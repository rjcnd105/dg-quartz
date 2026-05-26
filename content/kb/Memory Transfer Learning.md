---
publish: true
created: 2026-04-17T09:00:00Z
modified: 2026-04-17T09:00:00Z
tags:
  - kb
  - llm
  - agent
  - memory
  - transfer-learning
---

코딩 에이전트의 self-evolving memory는 기존에 같은 도메인 내부로만 활용되었다. MTL은 **이종 도메인 memory pool** (예: LiveCodeBench → SWEBench)에서 meta-knowledge가 전이됨을 실증. 결정적 원칙: **abstraction이 transferability를 지배**한다.

## 핵심 내용

Kim et al. (2026-04)에 따르면 coding agent memory는 4가지 format(Trajectory/Workflow/Summary/Insight)이 있으며, 6개 벤치마크 cross-domain 실험에서 평균 **+3.7%** gain (출처: [[Memory Transfer Learning How Memories are Transferred Across Domains in Coding Agents]]).

### 4가지 Memory Format

추상화 오름차순:

| Format | 구조 | 특성 |
|--------|------|------|
| **Trajectory** | (task, \[(action, obs), ...]) | 원시 실행 로그 전체. task-specific 최대 |
| **Workflow** | (goal, \[meaningful actions]) | 재사용 가능한 action 추출 |
| **Summary** | (task 요약, 경험 분석 1문단) | 성공·실패 이유 포함 |
| **Insight** | (title, description, content) | 구체 파일·세부사항 배제, 일반화된 원칙 |

### Core Finding 1: Cross-domain이 In-domain보다 강함

- **Insight memory 기준 평균 +3.7%**, 최대 +8.3% (MLGym-Bench)
- GPT-5-mini, DeepSeek V3.2, Qwen3-Coder 전부 gain (+1.8 ~ +2.6%)
- 기존 self-evolving method 대비:
  - ReasoningBank (97 memory, in-domain): 0.601
  - AgentKB (5,899 memory, general): 0.613
  - **MTL (431 memory, coding cross-domain): 0.630** — 가장 효율적

### Core Finding 2: 전이되는 것은 Meta-Knowledge

정성 분석: cross-domain memory 성공 기여 요인 분해 (실패→성공 전환 케이스)

- **Meta-knowledge** (procedural/behavioral guidance): 대부분. 예: inspect→edit→verify→submit workflow, API contract 준수, inline test here-doc validation
- **Algorithmic Strategy Transfer** (구체 알고리즘 전이): **5.5%에 불과**

즉 "이 문제 이렇게 풀어라"가 아니라 "이런 방식으로 접근해라"가 건너감. 예: LiveCodeBench 코딩 경험의 "inline Python here-doc으로 self-contained test 작성" 습관이 SWE-Bench Verified의 Django aggregate 버그 수정에 적용되어 성공.

### Core Finding 3: Abstraction → Transferability

추상화 수준과 전이 효과의 **양의 상관관계**.

정량 근거:

- **DBI**(Davies-Bouldin Index): Trajectory < Workflow < Summary < Insight로 상승 → benchmark 클러스터 분리 약화
- **LISI**(Local Inverse Simpson's Index) 상승 → 로컬 benchmark 혼합 강화
- 동일 format(Insight) 내에서도 task-agnostic(추상 top 30%)이 task-specific(bottom 30%) 대비 +1.1%

Trajectory가 위험한 이유: 정확한 command가 다른 환경에서 runtime error 유발. `OneHotEncoder(..., sparse=False)` 가 새 sklearn에서 깨지는 식.

### Negative Transfer 3가지 mode

Zero-shot 성공 → MTL 실패 케이스 분석:

1. **Domain-mismatched anchoring**: 구조적으로 무관한데 표면 유사한 memory가 misleading anchor로 작동. 잘못된 가정 주입, 핵심 제약·로직에서 이탈
2. **False validation confidence**: verification memory가 거짓 확신 생성. 공식 criteria 대신 피상적 check에 의존하는 self-confirming loop
3. **Misapplied best-practice transfer**: 성공 패턴의 무차별 이식. 과공학, task-specific semantics 침해 (예: R 파일 쓰기 routine을 C++에 적용)

→ 원인: **잘못된 retrieval** + **미흡한 adaptation**.

### Scaling Laws

- Memory pool 크기 1/4 → 2/4 → 3/4 → full: 성능 monotonic 증가
- Source domain 수 증가 → 성능 증가. 9개에서 최고
- 이유: 다양성 확보 → 관련 meta-knowledge retrieval 확률 증가

### Cross-Model Transfer

다른 모델이 생성한 memory도 유효. GPT-5-mini ↔ DeepSeek V3.2 ↔ Qwen3-Coder 양방향. 단, self-generated memory보다는 열세 → **meta-knowledge는 model-agnostic** 이지만 model-specific bias도 존재.

### Retrieval 방법론

단순 embedding similarity가 LLM reranking·adaptive rewriting보다 **우위**:

| 방법 | Avg |
|------|-----|
| Embedding Similarity | **0.630** |
| Adaptive Rewriting | 0.608 |
| LLM Reranking | 0.598 |
| No Memory | 0.584 |

해석: 동적 multi-step agent 설정에서 필요한 knowledge 예측 어려움. static retrieval 최적화 방법이 heterogeneous cross-domain에 일반화 안 됨. 대안: domain routing, step-wise memory retrieval.

## 실무 함의

- kb/ crystallize 설계: Trajectory 저장 지양, **Insight-level 추상화 우선**
- Cross-session memory pool 구성 시 도메인 다양성 확보
- Retrieval은 과도한 reranking보다 embedding similarity 베이스로 시작
- Negative transfer 경고: 표면적 similarity만으로 retrieve하면 anchor 오염 위험

## 관련 링크

- [[Agent Memory Systems]] — 4-format taxonomy는 Agent Memory Systems의 하위 분류
- [[Memory Intelligence Agent (MIA)]] — parametric + non-parametric memory 전반. MTL은 non-parametric 쪽 심화
- [[Test-Time Learning]] — self-evolving paradigm 전반, MTL은 그 중 cross-domain 축
- [[Agent Task Verification]] — "false validation confidence"는 Witness의 pre-commitment로 방어 가능
- 원문: https://arxiv.org/html/2604.14004v1
- 프로젝트: https://memorytransfer.github.io/
