---
publish: true
created: 2026-04-17T09:00:00Z
modified: 2026-04-17T09:00:00Z
tags:
  - kb
  - llm
  - inference
  - test-time-scaling
  - orchestration
---

Verifier 없이 진화적 self-evolution을 수행하는 test-time scaling 프레임워크. 핵심 통찰: **초기화 품질이 최종 성능을 지배**, 모델 내부 **confidence가 fitness 신호**로 충분. 강한 모델은 초기화·어려운 group에만 투입, 나머지는 싼 모델로 routing — cost 1.3~3.3배 절감.

## 핵심 내용

Maheswaran et al. (2026-04)에 따르면 verifier-free evolution(RSA 등)은 두 병목이 있다 (출처: [[Squeeze Evolve Unified Multi-Model Orchestration for Verifier-Free Evolution]]):

- **Diversity collapse**: 외부 검증 없이 반복하면 mode 좁아짐, pass@K 하락
- **Cost inefficiency**: 단일 강력 모델 uniform 사용은 경제성 파괴

### 통합 Evolutionary Framework

많은 test-time scaling 방법이 하나의 operator로 일반화 가능:

$$\Phi\_f(\mathcal{P}) = \text{recomb}\_f \circ \text{select}\_f(\mathcal{P})$$

| Method | k | select | recomb | fitness | model |
|--------|---|--------|--------|---------|-------|
| Majority Voting | 1 | 답 클러스터링 | identity | consensus 빈도 | 단일 |
| Self-Refinement | T | self-critique | 조건부 재작성 | NL critique | 단일 |
| RSA | T | K-subset | LLM aggregation | implicit | 단일 |
| AlphaEvolve | T | fitness-guided | LLM aggregation | 외부 verifier | multi |
| **Squeeze Evolve** | T | fitness-guided | mixed | confidence | **multi** |

### 4가지 실험 발견 (설계 정당화)

1. **Diversity가 pass@K 상한을 지배**. Single-model open-loop는 초기 loop 후 diversity 붕괴, pass@K 동반 하락. Multi-model routing이 complementary lineage 유지.
2. **Ancestor function이 최종 정확도를 지배**. Strong-init → Weak-agg (S→W) > Weak-init → Strong-agg (W→S).
   - HMMT'25 Qwen3-4B Thinking/Instruct: S→W 88% vs W→S 65% (**+23점**)
3. **Weak model도 candidate set이 강하면 강한 aggregator**. 4개 중 0개 correct → aggregation 정확도 0%, 4개 모두 correct → 100%. 쉬운 group은 싼 모델로 넘겨도 됨.
4. **Self/cross-model confidence가 fitness proxy로 유효**. 고-confidence subset은 correct trajectory 포함률·aggregation 성공률 둘 다 높음.

### Squeeze Evolve 알고리즘

- **Initialization**: 가장 비싼 Model 2로 N개 후보 전부 생성. 초기화 품질이 지배적이므로 절대 양보 불가.
- **Fitness 신호** 2가지:
  - _Group Confidence (GC)_: 이미 추론 중 생성된 top-K 토큰 logprob 집계. 자체 추가 비용 0 (self-confidence) 또는 prefill-only forward 1회 (cross-model)
  - _Group Diversity D_: 답 unique count. logprob 미제공 API(Gemini 등)용
- **Selection**: M개 그룹 (크기 K). uniform 또는 fitness-weighted sampling (temperature ζ).
- **Routing**: 3-tier
  - consensus 그룹 → lite aggregation (majority vote, LLM 미사용)
  - 나머지 중 per-problem percentile p 기준 "쉬움" → Model 1 (싼)
  - "어려움" → Model 2 (비싼)
- **Update**: replace (이전 population 폐기) 또는 accumulate (discovery 용).

단일 tunable 하이퍼파라미터: **routing percentile p**.

### 실증 (8개 벤치마크)

**Homogeneous (open + open)**:

| Task | Baseline | Savings | Acc 변화 |
|------|----------|---------|---------|
| AIME25 | Qwen3-30B-Thinking 89.2% | 1.4× | **+1.5** (90.7%) |
| HMMT25 | GPT-OSS-120B 89.7% | 1.6× | **+2.3** (92.0%) |
| GPQA-D | Qwen3-30B-Thinking 74.0% | 1.8× | **+1.9** (75.9%) |
| LCB-V6 | GPT-OSS-120B 75.9% | 2.0× | -0.3 |

**Heterogeneous (open + closed, GPT-5 mini)**:

- AIME25 1.8× savings **+1.2점**, HMMT25 1.7× 동등, GPQA 1.5× -1.4점
- 가장 aggressive (p=0): 3× savings, -1.5~-6점

**Multimodal (vision)**:

- MMMU-Pro heterogeneous: **text-only Qwen3.5** (이미지 아예 안 봄) + Kimi-2.5-Thinking, 2.7× savings, **-0.5점**(79.06 vs 78.58)
- 해석: **visual understanding은 초기화에서만 필요**. loop 0에 image grounded 된 후 aggregation은 텍스트로 충분.

**ARC-AGI-V2**:

- Squeeze Evolve 97.5% at $7.74/task → **SoTA cost-capability frontier**
- code execution 없이 Confluence Lab (97.9%, $11.77) / Imbue (95.1%, $8.71) 격파
- Gemini 3.0 Flash 추가해 3-way routing 하면 $5.93/task로 동일 정확도

**Circle Packing (verifier-free discovery)**:

- 2.635896 — AlphaEvolve (2.635862, verifier-based) 초과
- 코드 실행 없이 confidence만으로 open-ended 최적화. 최초 verifier-free evolutionary 방법.

### System 설계

- **Confidence engine (vLLM 커스텀)**: prefill-only scoring에서 13MB → 100B 전송. 4-10× 낮은 scoring latency. Qwen3-235B OOM 회피.
- **Latency-matched GPU pools**: Model 1·2 pool 크기를 loop service time 맞춤 할당. 미스매치 시 빠른 pool idle → 효과 상쇄.
- **Routing overhead**: end-to-end 지연 +2.4~4.3%만.
- **Fixed-budget throughput**: Qwen3-30B/235B pair 4-10×, GPT-OSS 20B/120B 1.4-3.4× 처리량 상승. 차이는 active-param asymmetry 때문.

### 한계

- Confidence·diversity는 noisy proxy. 희소 verification 혼합 시 개선 여지
- Population·group·loop 수 고정 → dynamic tuning 여지
- 완전한 trajectory 단위 작동 → intermediate step 단위 uncertain segment 재생성으로 절감 가능

## 관련 링크

- [[Autoreason]] — A/B/AB Borda로 self-refinement 개선. Squeeze Evolve와 상보: Autoreason은 품질·판단 개선, Squeeze는 cost·diversity
- [[Self-Evolving Code]] — persistent repo-scale evolution. Squeeze Evolve는 single-prompt test-time scaling — 축이 다름
- [[Test-Time Learning]] — test-time scaling 전반
- [[Agent Memory Systems]] — fitness로서 confidence 활용 패턴
- 원문: https://arxiv.org/html/2604.07725v2
- 코드: https://github.com/squeeze-evolve/squeeze-evolve
- 프로젝트: https://squeeze-evolve.github.io/
