---
publish: true
created: 2026-04-08T03:20:00Z
modified: 2026-04-08T03:20:00Z
tags:
  - kb
  - glossary
---

Supervised Fine-Tuning. 사전훈련(pre-training)된 LLM을 레이블이 있는 데이터셋으로 추가 학습시켜 특정 작업이나 출력 형식에 맞추는 과정이다.

## LLM 학습 파이프라인에서의 위치

1. **Pre-training** — 대규모 텍스트 코퍼스에서 다음 토큰 예측으로 언어 이해를 학습
2. **SFT** — (instruction, response) 쌍으로 구성된 데이터셋으로 미세조정. 모델이 지시를 따르고 원하는 형식으로 응답하도록 학습
3. **RLHF/DPO** — 인간 선호도 피드백으로 응답 품질을 추가 정렬

SFT는 "instruction tuning"이라고도 불린다 — 사전훈련된 모델이 자연어 지시를 이해하고 따르는 능력을 부여하는 단계이기 때문이다.

## 왜 중요한가

사전훈련만 거친 모델은 텍스트 완성에 능숙하지만 질문에 답하거나 지시를 따르지 못한다. SFT를 통해 모델이 대화형 어시스턴트로 동작할 수 있게 된다.

## 관련 문서

- [[Simple Self-Distillation]] — SFT 과정에서 self-distillation 기법 활용
