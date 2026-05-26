---
publish: true
created: 2026-05-06T08:44:23Z
modified: 2026-05-06T08:44:23Z
tags:
  - kb
  - psychology
  - decision-making
  - cognition
---

Cognitive ability and probability forecasting는 사람이 uncertain future event의 확률을 얼마나 calibrated하게 예측하는가와 general cognitive ability가 연결되는 문제다. Bath 보도자료는 English Longitudinal Study of Ageing 자료에서 IQ가 높을수록 life-expectancy probability forecast error가 작았다는 연구를 소개한다 (출처: [[New IQ research shows why smarter people make better decisions]]).

## 핵심 내용

연구는 50세 이상 England 표본에서 자기 생존 확률 예측을 수집하고, 이를 Office for National Statistics life table 기반 확률과 비교했다. Lifestyle, health, genetic longevity 같은 차이를 통제한 뒤에도 cognitive test score와 intelligence/education 관련 genetic marker가 더 정확한 probability estimate와 연결됐다고 보도자료는 설명한다.

핵심 claim은 "higher IQ가 더 나은 decision을 직접 만든다"라기보다, 더 정확한 probabilistic belief가 saving, retirement, investment, health decision 같은 선택의 입력 품질을 높인다는 것이다.

## 설계 implication

정보 설계 관점에서 이 연구는 사용자가 확률 계산을 스스로 하게 두는 interface의 위험을 보여준다. Health, finance, retirement 같은 high-stakes UI에서는 다음이 중요하다.

- base rate와 probability estimate를 명시적으로 제공
- raw statistic을 사용자가 mental arithmetic으로 변환하게 만들지 않음
- uncertainty와 confidence interval을 decision context에 맞게 표현
- lower numeracy user도 같은 decision quality에 접근하도록 explanation layer 제공

이 관점은 [[Laws of UX]]의 cognitive load, choice overload, chunking과 연결된다. 사용자가 판단해야 할 확률이 많고 복잡할수록 interface가 계산 부담을 덜어야 한다.

## 한계

보도자료는 연구의 핵심 결과를 요약하지만, causality 해석은 신중해야 한다. Genetic marker와 통제 변수를 사용하더라도, 실제 decision outcome은 income, education, access to advice, institutional context 같은 요인의 영향을 함께 받는다.

## 관련 링크

- [[Laws of UX]] — cognitive load와 decision support heuristic
- [[Affordances]] — 사용자가 어떤 action 가능성을 인식하는가
- 논문 DOI: https://doi.org/10.1037/pspp0000567
