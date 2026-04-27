---
publish: true
created: 2026-04-17T09:00:00Z
modified: 2026-04-17T09:00:00Z
tags:
  - kb
  - llm
  - self-refinement
  - evaluation
---

자기 반복 개선의 구조적 실패(prompt bias, scope creep, lack of restraint)를 A/B/AB 세 버전 경쟁 + 블라인드 Borda 투표로 해결하는 self-refinement 프레임워크. "Do nothing"이 1급 옵션.

## 핵심 내용

NousResearch/autoreason(SHL0MS, 2026)은 기존 self-refinement 방식이 세 가지 구조적 문제로 실패한다고 주장한다 (출처: [[NousResearchautoreason Autoresearch for subjective domains.]]).

- **Prompt bias**: 모델에 "비판해라"고 시키면 문제없는 출력에서도 문제를 환각.
- **Scope creep**: 매 pass마다 출력이 무한정 팽창.
- **Lack of restraint**: "수정 불필요"를 말하지 못함.

### A/B/AB 토너먼트

각 iteration에서 세 버전 생성:

- **A (incumbent)**: 변경 없음
- **B (adversarial revision)**: fresh critic + author가 생성한 개정판
- **AB (synthesis)**: A와 B를 결합한 fresh synthesizer 출력

**블라인드 판정**: Context를 공유하지 않는 3~7명의 fresh judge agents가 Borda count로 우승 선정. "Do nothing"(A) 선택 가능 → 불필요한 변경 억제.

수렴 조건: A가 연속 k=2번 우승하면 정지.

### 주요 결과

- **42/42 perfect sweep** (Haiku 3.5 + autoreason, 3개 task). 다른 baseline은 모두 single-pass 이하로 degrade.
- **CodeContests 150문제, private test**: Sonnet 4.6 autoreason 77% vs single-pass 73%. Haiku 3.5 autoreason 40% vs best-of-6 sampling 31% (동일 compute).
- **Scaling curve**: Haiku 3.5 (40%) → Haiku 4.5 (60%) → Sonnet 4 (64%) → Sonnet 4.6 (77%). Haiku 4.5에서 held-out 이득 소실 — generation-evaluation gap이 닫히는 transition point.
- **Weak model 파괴**: Critique-and-revise가 Haiku 3.5 출력을 15-pass 동안 59-70% 단어 수 감소. Autoreason은 이 붕괴를 차단.
- **Judge scaling**: 1명은 noisy+slow, 3명 OK, 7명이 수렴 3배 빠름.
- **Component ablation**: B 또는 AB 중 하나라도 제거하면 토너먼트 붕괴 (24 pass 수렴 → 2-3 pass 조기 수렴 = 비평 없이 통과).

### 왜 유효한가

- 각 judge에 fresh context → self-critique의 prompt bias 제거
- A가 1급 옵션 → "변경 필요 없다"를 표현 가능
- Length-controlled 평가에서도 21/28 승 — 단순 장황함의 승리가 아님

### 한계

Sonnet 4.6 이상 스케일에서 held-out task의 이득은 사라지기 시작. 논문은 8개 remedy 실험과 failure taxonomy를 공개.

> [!info] 톤
> 단일 출처(NousResearch repo + arXiv 미공개 PDF). 벤치 숫자는 hedging 톤. 재현 가능한 `human_eval/` 제공.

## 관련 링크

- [[Simple Self-Distillation]] — 자기 출력으로 SFT, 전제가 다름 (refinement가 아닌 data augmentation)
- [[Scale-Dependent Verbosity]] — 큰 모델의 과한 개선 성향, autoreason의 "do nothing" 옵션으로 완화 가능
- [[Memory Intelligence Agent (MIA)]] — peer-review 스타일 다중 reviewer 판정의 유사 패턴
- [[Self-Evolving Code]] — per-cycle rewrite+verify를 repo 전체 규모로 확장. formal verification gate가 Autoreason Borda 투표 기능과 상응
- 원문: https://github.com/NousResearch/autoreason
