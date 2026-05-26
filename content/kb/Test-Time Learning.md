---
publish: true
created: 2026-04-17T08:00:00Z
modified: 2026-04-17T08:00:00Z
tags:
  - kb
  - llm
  - agent
  - reinforcement-learning
  - online-learning
---

추론(inference) 시점에 탐색 피드백을 사용하여 모델 파라미터를 실시간으로 업데이트하는 학습 패러다임. 오프라인 훈련 후 frozen 배포하는 관례와 달리, 배포 중에도 모델이 계속 진화한다.

## 핵심 내용

[[Memory Intelligence Agent (MIA)]] 저자들에 따르면 TTL은 배치 단위로 탐색·저장·학습을 **동시 수행**하는 online learning 파이프라인이다 (출처: [[Memory Intelligence Agent]]).

### 오프라인 훈련과의 차이

| 축 | 오프라인 RL | Test-Time Learning |
|----|------------|-------------------|
| 메모리 컨텍스트 | 사전 수집 | 실시간 구성 |
| Rollout | multi-epoch | 단일 경로 |
| 파라미터 업데이트 | 훈련 후 동결 | 추론 중 계속 |
| 데이터 분포 | 고정 | 배포 환경에 따라 drift |

### MIA의 TTL 루프

각 배치마다:

1. Planner가 G개 plan 후보 rollout
2. Executor가 각 plan으로 환경과 상호작용 → G개 trajectory
3. LLM Judger가 정답성 평가 → positive/negative 분류
4. Memory Manager가 최단 성공 + 랜덤 실패 한 쌍을 workflow로 압축 저장 (비파라메트릭)
5. 보상·advantage 계산 후 [[GRPO]]로 Planner 파라미터 업데이트 (파라메트릭)

**Executor는 frozen 유지**. 이유: 외부 환경과 상호작용하는 "operational terminal"이므로 안정성이 중요. Planner만 "cognitive brain"으로서 진화.

### Meta Plan Memory

G개 rollout 중 최종 응답을 고를 때, 과거 contrastive pair(최단 성공 + 랜덤 실패)를 참조하는 Router가 품질 기반으로 하나를 선택. 단순 다수결이 아니라 메모리 prior를 활용한 ranking.

### 비지도 환경에서의 자기진화

Ground truth가 없는 open-world에서는 peer-review 스타일 판단(Logic / Credibility / Validity reviewer + Area Chair)을 supervision proxy로 사용. MIA 실험에서 비지도 설정으로도 3 epoch에 걸쳐 성능이 누적 상승 (2Wiki 71.6 → 73.4 → 74.7).

### 왜 지금 유망한가

- RLHF가 "배포 후 동결"의 한계를 드러낸 상황에서, 환경 피드백을 직접 학습 신호로 쓰려는 시도 증가
- [[GRPO]] 같은 그룹 기반 advantage 계산이 multi-rollout을 효율화
- Agent의 exploration이 자연히 다수의 trajectory를 생성 → 학습 데이터로 재활용 가능

### 위험

- 파라미터 drift: 배포 중 분포 변화로 원래 능력 손실 가능
- 안전성: 추론 중 업데이트되는 모델은 감사가 어려움
- MIA는 Planner만 업데이트하여 이 위험을 부분 완화 (Executor는 동결)

> [!info] 톤
> 단일 출처(MIA 논문). TTL이라는 개념 자체는 더 넓은 커뮤니티에서 쓰이지만, 본 페이지 설명은 MIA 관점 중심. 후속 출처로 보강 예정.

## 관련 링크

- [[Memory Intelligence Agent (MIA)]] — TTL을 중심 메커니즘으로 활용
- [[GRPO]] — TTL에서 쓰이는 정책 최적화
- [[Agent Memory Systems]] — TTL은 파라메트릭 메모리 업데이트의 한 방법
- [[SFT]] — 오프라인 훈련의 대표. TTL과 대비
