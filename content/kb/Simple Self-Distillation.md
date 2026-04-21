---
publish: true
created: 2026-04-08T03:15:00Z
modified: 2026-04-08T03:15:00Z
tags:
  - kb
  - llm
  - self-distillation
  - code-generation
  - fine-tuning
---

모델이 자체 출력을 샘플링한 뒤 그 샘플로 SFT(Supervised Fine-Tuning)하는 기법. 외부 verifier, teacher model, RL 없이 코드 생성 성능을 크게 향상시킨다.

## 핵심 내용

\*\*Simple Self-Distillation (SSD)\*\*의 절차는 단순하다 (출처: [[Embarrassingly Simple Self-Distillation Improves Code Generation]]):

1. 특정 temperature와 truncation 설정으로 모델 자체 출력을 샘플링
2. 해당 샘플로 표준 SFT 수행

외부 reward model이나 RL 파이프라인 없이도 작동하는 이유는 **precision-exploration conflict** 해소에 있다. LLM 디코딩에서 정밀도(precision)가 중요한 위치에서는 distractor 토큰을 줄이고, 탐색(exploration)이 필요한 위치에서는 다양성을 유지하도록 토큰 분포를 맥락적으로 재형성한다.

### 성능

| 모델 | 벤치마크 | Before | After |
|------|----------|--------|-------|
| Qwen3-30B-Instruct | LiveCodeBench v6 pass@1 | 42.4% | **55.3%** |

- 개선이 **어려운 문제에서 집중적으로** 발생
- Qwen, Llama 계열 4B/8B/30B에서 모두 작동
- Instruct + thinking 변형 모두에 적용 가능

### 의의

Verifier나 teacher model 없이 모델이 스스로 개선되는 가장 단순한 형태. 복잡한 RLHF/RLAIF 파이프라인의 대안으로, 코드 생성 도메인에서 검증되었다.

## 관련 링크

- [[Scale-Dependent Verbosity]] — LLM 디코딩 행동의 또 다른 발견: 큰 모델의 과도한 설명이 성능을 저하시키는 현상
