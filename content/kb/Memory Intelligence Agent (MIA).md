---
publish: true
created: 2026-04-17T08:00:00Z
modified: 2026-04-17T08:00:00Z
tags:
  - kb
  - llm
  - agent
  - memory
  - reinforcement-learning
---

Manager-Planner-Executor 3분할 아키텍처로 Deep Research Agent의 메모리 문제를 해결하는 프레임워크. 비파라메트릭(memory buffer) + 파라메트릭(훈련된 Planner) 이중 메모리, alternating RL, test-time learning을 결합한다.

## 핵심 내용

Qiao et al. (ECNU, 2026)에 따르면 MIA는 기존 long-context 기반 agent 메모리의 한계(attention dilution, noise, 저장 비용, 검색 비용)를 비파라메트릭·파라메트릭 메모리의 이원화로 해결한다 (출처: [[Memory Intelligence Agent]]).

### 아키텍처: Manager–Planner–Executor

| 컴포넌트 | 역할 | 모델 예 |
|----------|------|---------|
| Memory Manager | 과거 trajectory를 **비파라메트릭**으로 저장·검색. 요약·압축 전담 | Qwen3-32B (frozen) |
| Planner | 질문에 대한 search plan을 생성. **파라메트릭** 메모리 담당. 훈련·업데이트됨 | Qwen3-8B |
| Executor | Plan을 [[ReAct]] 루프로 실행, 도구 호출·결과 분석 | Qwen2.5-VL-7B |

### 이중 메모리

- **비파라메트릭 (Memory Manager)**: 성공 trajectory 중 최단 경로(positive paradigm)와 실패 trajectory 중 랜덤 샘플(negative paradigm)을 workflow 요약으로 압축 저장. 3축 점수로 검색 — semantic similarity, value reward(성공률), frequency reward(저빈도 항목 탐색 장려).
- **파라메트릭 (Planner parameters)**: trajectory를 Planner 가중치로 내재화. 저장 폭발 방지.

두 메모리가 **양방향 변환 루프**를 구성. 탐색 중 실시간으로 비파라메트릭 저장 + 파라메트릭 업데이트가 동시 진행.

### Alternating RL 훈련 ([[GRPO]] 기반)

두 단계 교대:

1. **Stage 1 (Executor 훈련)**: Planner frozen. Executor가 plan을 파싱·실행하는 능력 강화. 보상은 `0.7·정답 + 0.2·툴 호출 성공 + 0.1·포맷`.
2. **Stage 2 (Planner 훈련)**: Executor frozen. Planner가 메모리 컨텍스트로부터 계획·반성하는 능력 강화. 보상은 `0.7·최종 정답 + 0.2·중간 정답 + 0.05·reflection + 0.05·포맷`.

### Test-Time Learning (TTL)

[[Test-Time Learning]] 섹션 참조. 추론 중 배치마다 exploration → 환경 feedback → 비파라메트릭 추출 → Planner 파라미터 업데이트가 동시 진행. 다중 에포크에 걸쳐 같은 데이터셋을 다시 만나면 성능이 누적 상승 (예: 2Wiki 71.6 → 73.4 → 74.7 across 3 epochs, unsupervised).

### Reflect-Replan

Executor 실행 후 Planner가 feedback을 보고 plan 수정 여부 결정. 무한 재계획 방지를 위해 **한 번만** 트리거.

### 비지도 평가 (Peer-Review 스타일)

Ground truth가 없는 open-world에서 LLM-as-a-judge의 "hallucinated objectivity" 문제를 완화하기 위해:

- Reviewer 3인: Logic / Credibility / Validity (각각 Qwen3-32B instance, structured prompt)
- Area Chair 1인: 3인의 JSON 평가를 meta-analysis. 평균이 아닌 **fatal flaw 우선 판단**.

### 성능 요약

- GPT-5.4에 MIA 결합 시 LiveVQA +9%, HotpotQA +6%
- Qwen2.5-VL-7B Executor + MIA가 Qwen2.5-VL-32B + ReAct 대비 평균 +18%
- 이전 SOTA memory baseline(Memento 등) 대비 7개 벤치 평균 +5%
- 비지도 MIA도 대부분 지도 baseline 상회

## 왜 long-context보다 나은가

저자들은 RAG/Mem0/A-Mem 같은 long-context 방식이 "No Memory" baseline보다 **오히려 못한** 경우가 많음을 관찰한다. 원인은 컨텍스트 팽창 → 노이즈 → 추론 저하. MIA처럼 메모리를 **Planner의 prior로만** 쓰고 Executor에는 plan만 넘기면 이 문제가 해결된다.

> [!info] 톤
> 현재 `kb-sources` 1개 (arXiv preprint). 벤치 숫자·설계는 hedging 톤("저자에 따르면", "실험에 따르면")으로 기록. 재현·외부 평가가 쌓이면 확정 톤으로 전환.

## 관련 링크

- [[Agent Memory Systems]] — agent 메모리의 일반 분류·선행 기법
- [[Test-Time Learning]] — MIA의 핵심 학습 패러다임
- [[ReAct]] — Executor가 따르는 thought-action 루프
- [[GRPO]] — alternating RL의 기반 알고리즘
- [[LLM Harness]] — 모델 주변 인프라 자동 최적화의 병행 사례
- [[LLM Wiki 패턴]] — "지식을 저장소에 축적한다"는 유사 모티프, 다른 도메인
- 원문: https://arxiv.org/html/2604.04503v3
