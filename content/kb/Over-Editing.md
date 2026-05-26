---
publish: true
created: 2026-04-23T00:00:00Z
modified: 2026-04-23T00:00:00Z
tags:
  - kb
  - llm
  - coding
  - evaluation
  - prompt-engineering
---

LLM 코딩 모델이 **필요 이상으로 코드를 고쳐 쓰는 경향**. 출력은 기능적으로 정확하지만 원본보다 구조적으로 크게 발산한다. 단일 off-by-one 수정 요청에 함수 전체 재작성·helper 추가·변수 이름 변경·입력 검증이 섞여 나오는 패턴이 대표적이다 (출처: [[Coding Models Are Doing Too Much]]).

> [!info] 단일 출처 주의
> NUS 학부 연구(nreHieW, 2026)의 블로그 종합 단일 출처. 데이터셋과 방법론은 공개되어 있으나 벤치마크가 단일 함수 수준에 한정되며 SWE-Bench 류의 agentic task는 다루지 않는다.

## 왜 문제인가

- **Code review 병목 증폭**: 리뷰어는 diff가 커지면 "무엇이·왜·안전한가"를 파악하기 어렵다. 함수가 통째로 재작성되면 인지 부하가 폭증한다.
- **Test-invisible 실패**: 기능 정확성(Pass@1)은 통과하므로 테스트가 잡지 못한다. Brown-field 실패 mode이나 green-field에서는 이슈가 약하다.
- 팀이 이미 합의한 스타일·구조가 모델 재작성으로 조용히 무너진다.

정의: 모델 출력이 기능적으로 맞으면서 **최소 수정이 요구하는 것보다 구조적으로 더 발산**하면 over-editing.

## 측정 방법

- **Token-level Levenshtein**: Python tokenizer로 쪼갠 뒤 토큰 단위 edit distance. `someotherfunctionname` 전체 치환이 단일 token diff로 잡힌다 (character Levenshtein 19 vs token 1).
- **Added Cognitive Complexity**: Cyclomatic Complexity 개선판. Nesting·재귀·혼합 논리에 가중치. Value-change-only 버그에서는 올바른 수정은 ΔCC = 0 이어야 한다.
- **상대 패치 점수**: `S(M) = d(M,C) - d(G,C)`. Corrupted 입력 C, ground truth G, 모델 출력 M. 0 수렴 = 최소 수정 접근.

데이터셋: **BigCodeBench 400문제**를 프로그램 방식으로 corrupt (`<` → `<=`, `+` → `-`, `True` → `False` 등). LLM이 bug를 소개하지 않아 ground-truth 최소 수정이 정확히 corruption의 역산. 결과적으로 minimality가 construction에 의해 보장된다.

## 모델 성능 (frontier reasoning)

| Model | Pass@1 ↑ | Norm. Levenshtein ↓ | Added CC ↓ |
|-------|----------|---------------------|------------|
| Claude Opus 4.6 | **0.912** | **0.060** | 0.200 |
| Gemini 3.1 Pro Preview | 0.858 | 0.145 | 0.501 |
| GLM 5 High | 0.859 | 0.099 | 0.320 |
| Qwen 3.6 Plus | 0.858 | 0.145 | **0.048** |
| GPT-5.4 High | 0.723 | 0.395 | 2.313 |
| GPT-5 High | 0.713 | 0.438 | 3.832 |

(출처: [[Coding Models Are Doing Too Much]])

- Claude Opus 4.6가 정확성과 최소성을 동시에 달성한 유일 모델.
- GPT-5.4 / GPT-5 는 over-editing 최악. 이는 [[Scale-Dependent Verbosity]]에서 관찰된 "큰 모델의 과잉 elaboration"과 동형 현상이다.
- Reasoning 모델은 대체로 non-reasoning 쌍보다 **더 많이 고쳐 쓴다** (Opus 4.6은 예외). 이유: 확장된 추론이 "더 나은 구현"으로 모델을 유도.

## Prompting으로 교정

`"IMPORTANT: Try to preserve the original code and the logic of the original code as much as possible"`를 추가하면:

- 모든 모델이 Levenshtein 감소. 대부분 Pass@1도 향상 (search space 축소 효과).
- Reasoning 모델이 개선 폭이 크다 (instruction following 우위).
- GPT-5 / GPT-5.4 는 prompting gap이 가장 크다. Capability 한계 아님, **기본 거동 문제** — 지시하면 steerable.

## Training: 최소 수정 학습

Qwen3 4B base에서 4가지 방법 비교:

| 방법 | In-domain Pass@1 | OOD Pass@1 | OOD Levenshtein | LiveCodeBench Δ |
|------|------------------|------------|-----------------|-----------------|
| SFT | **0.932** | 0.458 (붕괴) | -0.008 | **-0.149** |
| rSFT | 0.782 | 0.780 | 0.107 | -0.069 |
| DPO | 0.752 | **0.787** | 0.092 | -0.046 |
| **RL** | 0.802 | 0.782 | **0.050** | **+0.006** |

- **SFT memorize, RL generalize**: SFT는 corruption 역산을 암기하여 OOD에서 기본 bug fix 능력까지 잃는다(43% catastrophic forgetting). RL만 OOD에서 모든 축 개선 + 일반 coding 능력 보존.
- **LoRA rank 64 ≈ full RL**: 스타일 수준 행동 교정은 소량 파라미터로 충분.

해석: "SFT는 암기, RL은 일반화" 기존 명제와 일치 (Chu et al. 2501.17161). RL의 KL-minimal 편향이 원 분포에서 덜 벗어나게 만들어 catastrophic forgetting을 완화한다.

## 실전 시사점

1. **프롬프트에 "preserve original" 추가**: 간단한 교정. 특히 GPT-5.x 계열에서 효과 큼.
2. **Diff 크기를 리뷰 지표로**: 기능 테스트 통과가 전부가 아니다.
3. **Opus 4.6 기본 사용**: brown-field maintenance에서 diff 관리가 중요하면 기본 선택.
4. **Style 조정에 full fine-tune 불필요**: LoRA rank 32-64 수준이면 대부분 획득 가능.

## 관련 링크

- [[Scale-Dependent Verbosity]] — 큰 LLM의 장황함이 정확도 하락을 부르는 동형 현상. Over-editing은 "코드 영역의 verbosity"
- [[SFT]] — 본 실험에서 OOD 붕괴를 보인 방법
- [[GRPO]] — RL-based 코딩 모델 학습의 대표 알고리즘
- [[Simple Self-Distillation]] — 자체 출력으로 학습 분포 shift를 최소화하는 접근
- 원문: https://nrehiew.github.io/blog/minimal\_editing/
- 코드: https://github.com/nreHieW/fyp
