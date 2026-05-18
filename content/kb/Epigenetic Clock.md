---
publish: true
created: 2026-05-07T03:10:01Z
modified: 2026-05-18T06:34:02Z
tags:
  - kb
  - glossary
  - biology
  - aging
  - epigenetics
---

Epigenetic clock은 [[DNA methylation]] pattern 같은 epigenetic marker를 사용해 tissue나 organism의 age-related state를 추정하는 statistical model이다. 대부분 machine learning model이며, CpG methylation feature의 조합으로 chronological age, morbidity/mortality risk, intervention response proxy를 예측한다.

## 세대별 구분

- First-generation clock: chronological age 예측 정확도 중심.
- Second-generation clock: clinical biomarker, mortality, healthspan proxy와의 예측력을 강화.
- Pace-of-aging clock: 특정 시점의 biological age보다 aging rate나 physiological decline 속도에 초점.
- Cell-type/single-cell clock: mixed tissue composition 문제를 줄이고 세포별 aging state를 보려는 방향.

## 최신 연구 맥락

2025 Nature Reviews Genetics review는 clock 해석의 핵심 문제를 statistical construction, cell-type heterogeneity, single-cell resolution, intervention-readout validity로 정리한다. 최근 방법론은 cheap targeted methylation assay, single-cell methylome, multi-omics clock, species-wide mammalian clock 쪽으로 확장되고 있다.

## 해석 경계

Clock age가 낮아졌다는 것은 biomarker가 변했다는 뜻이지, 임상적으로 의미 있는 rejuvenation이나 disease-risk reduction이 검증됐다는 뜻은 아니다. Intervention claim에서는 randomization, control arm, tissue relevance, endpoint durability가 필요하다.

## 관련 링크

- [[DNA methylation]]
- [[Epigenetic Skin Aging]]
- [[Short-Term Diet and Biological Age Markers]] — 4주 식단 개입의 biomarker-based biological age 변화 사례
- [[Biomarker Interpretation Ladder]] — clock age 변화와 clinical endpoint를 분리하는 해석 패턴

## 자료

- 2025 epigenetic ageing clocks review: https://www.nature.com/articles/s41576-024-00807-w
- DNA methylation clock theory review: https://www.nature.com/articles/s41576-018-0004-3
- TIME-seq targeted clock method: https://pubmed.ncbi.nlm.nih.gov/38200273/
