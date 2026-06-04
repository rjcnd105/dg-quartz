---
publish: true
created: 2026-05-27T03:07:26Z
modified: 2026-05-27T03:07:26Z
tags:
  - kb
  - llm
  - agent
  - skill
  - optimization
---

SkillOpt는 agent skill 문서를 frozen model 바깥의 trainable state로 보고, rollout feedback으로 skill text를 제한적으로 업데이트하는 text-space optimization 방법이다 (출처: [[Introduction]]).

## 핵심 내용

SkillOpt의 중심 주장은 skill을 한 번 작성하는 prompt artifact가 아니라, scored trajectory를 통해 반복 개선되는 외부 절차 메모리로 다룰 수 있다는 것이다. Target model과 execution harness는 고정하고, 별도 optimizer model이 rollout 성공·실패를 읽어 skill 문서에 대한 add/delete/replace edit을 제안한다.

핵심 loop:

1. target model이 현재 skill로 task batch를 실행한다.
2. optimizer model이 성공·실패 trajectory를 minibatch reflection으로 분석한다.
3. 제안 edit을 merge/rank하고 textual learning-rate budget 안에서 소수만 적용한다.
4. candidate skill을 held-out selection split에서 평가한다.
5. selection score가 엄격히 개선될 때만 current/best skill로 받아들인다.

이 구조는 [[Self-Evolving Code]]의 "수정 → 검증 → 채택" 루프와 비슷하지만, 수정 대상이 codebase가 아니라 compact `best_skill.md`라는 점이 다르다.

## 안정화 장치

- **Bounded text updates**: skill 전체 rewrite가 아니라 제한된 수의 edit만 허용해 이전에 잘 작동한 절차를 보존한다.
- **Validation gate**: selection split에서 현재 skill보다 좋아질 때만 채택한다. Tie도 reject한다.
- **Rejected-edit buffer**: 실패한 edit과 score drop을 버리지 않고, 같은 epoch의 후속 reflection에 negative feedback으로 제공한다.
- **Epoch-wise slow/meta update**: 단기 failure fix와 장기적으로 유지해야 할 procedural regularity를 분리한다.

저자들은 이 조합을 weight-space training의 batch size, learning rate, validation, momentum에 대응시키지만, 실제 산출물은 모델 가중치가 아니라 사람이 읽을 수 있는 skill text다.

## 평가 신호

논문은 여섯 benchmark, 일곱 target model, direct chat/Codex/Claude Code 세 execution mode에서 SkillOpt를 평가했다고 보고한다. 저자 주장에 따르면 SkillOpt는 52/52 evaluated cells에서 best 또는 tied-best였고, GPT-5.5 direct chat 평균은 no-skill 대비 +23.5점, Codex harness는 +24.8점, Claude Code harness는 +19.1점 개선됐다.

이 수치는 preprint의 self-reported benchmark 결과다. 독립 재현, benchmark leakage, evaluator 품질, 실제 skill artifact 공개 범위가 확인되기 전에는 "검증된 일반 법칙"보다 "강한 실험 주장"으로 읽는 편이 맞다.

## 한계

SkillOpt는 reliable feedback이 있는 task에 잘 맞는다. 자동 verifier, exact-match metric, executable check, 명확한 held-out split이 없으면 validation gate가 약해지고, open-ended writing이나 subjective research workflow에서는 model-based judge 또는 human evaluation 품질이 병목이 된다.

또한 deployed skill은 작지만 training 비용은 별도로 든다. 같은 domain skill을 여러 번 재사용할 때는 amortization이 가능하지만, one-off task에는 과할 수 있다.

## 관련 링크

- [[Agent Skill Representation]] — skill text를 구조화해 discovery/review에 쓰는 접근
- [[Self-Evolving Code]] — persistent artifact를 수정하고 verifier로 채택하는 더 큰 codebase 단위 loop
- [[Agent Task Verification]] — agent 완료 주장과 skill improvement를 독립 검증하는 패턴
- [[Over-Editing]] — uncontrolled rewrite가 유용한 절차를 지우는 실패 모드
- [[SFT]] — model weight를 바꾸는 adaptation 축. SkillOpt는 weight를 바꾸지 않는다
- 원문: https://arxiv.org/html/2605.23904v2
