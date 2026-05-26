---
publish: true
created: 2026-05-06T08:44:23Z
modified: 2026-05-06T08:44:23Z
tags:
  - kb
  - ux
  - design
  - frontend
---

Laws of UX는 interface design에서 자주 쓰이는 심리학·인지과학 기반 heuristic 모음이다. 개별 법칙은 절대 규칙이 아니라 선택지 수, 기억 부담, 목표 진행감, 시각 grouping 같은 user perception 변수를 점검하는 lens로 써야 한다 (출처: [[Home]]).

## 핵심 내용

Laws of UX 목록은 크게 네 묶음으로 볼 수 있다.

### 인지 부담과 선택

- **Hick's Law / Choice Overload**: 선택지 수와 복잡도가 늘수록 decision time과 부담이 늘어난다.
- **Miller's Law / Chunking / Working Memory**: 정보는 작은 단위를 의미 있는 group으로 묶을 때 더 쉽게 처리된다.
- **Cognitive Load / Selective Attention**: interface 이해와 조작에 필요한 mental resource가 높아질수록 사용자는 goal-relevant signal만 보려 한다.

### 시각 grouping

- **Law of Proximity, Similarity, Common Region, Uniform Connectedness**: 가까이 있거나, 비슷하거나, 같은 boundary 안에 있거나, 시각적으로 연결된 요소는 같은 group으로 해석된다.
- **Law of Pragnanz**: 사람은 복잡하거나 모호한 형태를 가능한 단순한 구조로 해석하려 한다.
- **Von Restorff Effect**: 유사한 요소들 사이에서 다른 하나가 더 잘 기억된다.

### Interaction speed와 target acquisition

- **Doherty Threshold**: system response가 약 400ms 안에 돌아오면 사용자와 computer가 서로 기다리지 않는 느낌을 준다.
- **Fitts's Law**: target acquisition time은 target까지 거리와 target 크기의 함수다. 자주 쓰는 control은 크고 가까워야 한다.
- **Jakob's Law**: 사용자는 다른 site/app에서 배운 convention을 현재 interface에도 기대한다.

### 경험의 기억과 진행감

- **Goal-Gradient Effect**: 목표에 가까워질수록 행동 동기가 커진다.
- **Peak-End Rule**: 전체 평균보다 peak moment와 ending이 경험 평가에 강하게 작용한다.
- **Serial Position Effect**: series의 첫 항목과 마지막 항목이 더 잘 기억된다.
- **Zeigarnik Effect**: 완료되지 않았거나 interrupted task가 더 오래 기억된다.

## 실전 사용

이 법칙들은 design decision의 증거를 대신하지 않는다. 좋은 사용 방식은 화면을 보고 "이 control이 왜 여기에 있어야 하는가", "선택지가 너무 많지는 않은가", "같은 group으로 보여야 할 요소가 실제로 그렇게 보이는가"를 점검하는 checklist로 쓰는 것이다.

특히 operational UI에서는 aesthetic-usability effect를 오해하면 안 된다. 보기 좋은 interface는 더 usable하게 인식될 수 있지만, 실제 workflow latency, target size, option architecture, error recovery를 대체하지 못한다.

## 관련 링크

- [[Cognitive Ability and Probability Forecasting]] — probability estimate를 interface가 어떻게 보조해야 하는가
- [[Affordances]] — user가 어떤 action 가능성을 인식하는가
- [[Fluid Responsive Design]] — viewport보다 component와 content constraints 중심으로 layout 설계
- [[CSS Container Queries]] — component-level responsive design primitive
