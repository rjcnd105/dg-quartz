---
publish: true
created: 2026-04-17T09:00:00Z
modified: 2026-04-17T09:00:00Z
tags:
  - kb
  - llm
  - agent
  - orchestration
  - ml-engineering
---

Long-horizon ML research engineering 자율 에이전트 시스템. 핵심 원칙: **thin control over thick state** — orchestrator는 얇은 요약으로만 통제하고, 실제 state는 파일 기반 공유 workspace에 두껍게 유지.

## 핵심 내용

Chen et al. (2026-04)에 따르면 장기 ML 연구 엔지니어링(논문 재현, 실험 반복)에서는 로컬 추론 품질보다 **상태 연속성**이 bottleneck이다 (출처: [[Toward Autonomous Long-Horizon Engineering for ML Research]]).

**문제 설정**: 논문 받으면 Docker 환경·GPU·시간 예산 내에서 from-scratch 재현. PaperBench에서 기존 최고 agent 21% vs 인간 PhD 41%(48시간).

### Thin Control over Thick State

Control ≠ State. 분리하면 둘 다 확장 가능.

- **Control (thin)**: Orchestrator가 stage 수준 결정만. workspace map $m_t = \mathcal{M}(W_t)$ — 경량 텍스트 인덱스. 결정은 $m_t$ + concise summary 기반.
- **State (thick)**: paper 분석, plan, 코드, 로그, 실험 결과가 파일로 durable하게 누적. 대화 handoff에 state 실어 나르지 않음.

결정 시 _progressive disclosure_: specialist는 map으로 네비게이트, 필요한 artifact만 on-demand read, 완료 시 `(summary, ΔW)` 반환.

### File-as-Bus 프로토콜

공유 workspace 자체가 coordination 기질. 대화가 아니라 **파일이 메시지**.

3가지 role-aligned region:

- `paper_analysis/` — 구조화된 논문 이해, 타깃 메트릭, ambiguity
- `submission/` — runnable reproduction repo, `reproduce.sh` 진입점
- `agent/` — `prioritized_task.md`, `plan.md`, `impl_log.md`, `exp_log.md`, `experiments/` 하위

**Permission-scoped**: 각 Tier-1 specialist는 자기 role region에만 write 권한. 로그는 append-only + iteration-structured. → cross-agent 간섭 감소, 추적성 향상.

핵심 속성: workspace는 **system of record**. agent는 대화 맥락이 아니라 현재 workspace state에서 re-enter.

### 계층적 Orchestration (Agent-as-Tool)

3-tier 구조:

- **Tier 0 (Orchestrator)**: stage 수준 통제, 요약과 map만 유지
- **Tier 1 (Specialists)**: Paper Comprehension, Prioritization, Implementation (full/fix 모드), Experimentation, Generic Helper. Orchestrator에게 **tool처럼** 노출 (shell·file·web search와 동일 interface)
- **Tier 2 (Subagents)**: 옵션. 깊이 재귀 금지. 구조 추출, baseline 분석 등 leaf 작업만

**Agent-as-Tool**이 핵심: 위임이 Orchestrator의 native decision space 안 액션. 경량 작업은 직접 처리, 비용 대비 이득 있을 때만 specialist 호출.

### 실증 (PaperBench + MLE-Bench Lite)

- **PaperBench**: AiScientist 33.73 avg vs 최강 baseline 22.58 (+11.15). 인간 41%에 근접.
- **MLE-Bench Lite**: Any Medal 81.82% (Gemini-3-Flash / GLM-5 둘 다). 공식 leaderboard 최고 77.27% 초과.
- **비용 효율**: IterativeAgent $54.90/task vs AiScientist $12.20/task (GLM-5). 더 많은 interaction만으로는 부족 — _조직된_ interaction이 관건.

### Ablation 핵심

File-as-Bus 제거 시:

- PaperBench -6.41점
- MLE-Bench Lite Any Medal **-31.82점**

MLE-Bench에서 특히 유의미: Valid Submission·Bronze 는 유지되지만 Above Median·Silver·Gold가 무너짐. → **File-as-Bus는 후기 라운드 refinement에 결정적**. 초기 runnable scaffold 만드는 데는 덜 중요.

Hierarchical orchestration (non-hierarchical 대비)도 별도 기여. File-as-Bus 제거해도 BasicAgent보다는 여전히 앞섬 → 두 메커니즘이 독립적 기여.

### Evidence-Driven Loop

1. Paper comprehension → prioritization (execution contract 확립)
2. Runnable scaffold 먼저 세움
3. implementation ↔ experimentation 교대. 실행 결과(메트릭 gap, 실패 trace, 리소스 병목)가 다음 액션 결정
4. 실패 trace가 durable artifact로 기록 → 후속 round가 rediscover 없이 바로 대응

## 관련 링크

- [[File-as-Bus]] — 파일 기반 coordination 프로토콜
- [[Memory Intelligence Agent (MIA)]] — parametric + non-parametric memory 관점. File-as-Bus는 non-parametric 외부 메모리의 한 구현
- [[Agent Memory Systems]] — durable artifact 유형 (trajectory/workflow/summary/insight)
- [[Agent Task Verification]] — Witness oath도 파일 기반 verdict, AiScientist의 exp\_log와 유사한 durable evidence 패턴
- [[Self-Evolving Code]] — Multi-agent + 디렉토리 ownership으로 1.2M LoC 진화. Tier 분리 철학 공유, isolation 구현만 다름
- 원문: https://arxiv.org/html/2604.13018v1
- 코드: https://github.com/AweAI-Team/AiScientist
