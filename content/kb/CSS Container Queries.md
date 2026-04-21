---
publish: true
created: 2026-04-08T03:15:00Z
modified: 2026-04-08T03:20:00Z
tags:
  - kb
  - css
  - responsive-design
---

# CSS Container Queries

`@container` 규칙을 사용하여 뷰포트가 아닌 개별 컨테이너 요소의 크기에 따라 스타일을 적용하는 기능이다. `@media` 쿼리의 한계를 보완하며, 컴포넌트 수준의 반응형 디자인을 가능하게 한다. 모든 주요 브라우저에서 지원된다. (출처: [[Important CSS features web developers should know in 2025]])

## 기본 사용법

1. 부모 요소를 `container-type: inline-size`로 컨테이너로 등록
2. 자식 요소에서 `@container` 규칙으로 컨테이너 크기 기반 스타일 적용

```css
.list-container {
  container-type: inline-size;
}

.list {
  display: flex;

  @container (max-width: 250px) {
    flex-direction: column;
  }
}
```

## @media vs @container

`@media`는 전역 뷰포트 크기에만 반응한다. 리사이즈 가능한 패널, 사이드바, 대시보드 위젯처럼 컨테이너 크기가 뷰포트와 비례하지 않는 경우에는 `@container`가 필요하다. (출처: [[Important CSS features web developers should know in 2025]])

## Container Units

뷰포트 상대 단위(`vw`, `vh`)와 유사하되, 컨테이너의 크기를 기준으로 하는 단위들이다. (출처: [[Important CSS features web developers should know in 2025]])

| 단위 | 설명 |
|------|------|
| `cqw` | 컨테이너 너비의 1% |
| `cqh` | 컨테이너 높이의 1% |
| `cqi` | 컨테이너 인라인 크기의 1% |
| `cqb` | 컨테이너 블록 크기의 1% |
| `cqmin` | `cqi`와 `cqb` 중 작은 값 |
| `cqmax` | `cqi`와 `cqb` 중 큰 값 |

높이 기반 쿼리를 사용하려면 `container-type: size`로 설정해야 한다(`inline-size`는 너비만 추적).

## calc-size()

`auto`, `fit-content` 같은 비고정 크기 값에서 고정 크기로의 전환 애니메이션을 CSS만으로 처리하는 실험적 함수다. 과거에는 JavaScript로 요소 크기를 계산해야 했던 문제를 해결한다. 아직 모든 브라우저에서 지원되지 않으므로 프로덕션 사용 시 폴백이 필요하다. (출처: [[Important CSS features web developers should know in 2025]])

```css
height: calc-size(auto, min(size, 130px));
```

## 최신 동향 (2026-04)

### Container Size Queries — Baseline 안정

Container size queries는 2023년부터 Baseline 지원이며, 2026년 기준 전 세계 브라우저 95% 이상 커버:

| 브라우저 | 지원 시작 버전 |
|---------|-------------|
| Chrome | 105+ |
| Edge | 105+ |
| Firefox | 110+ |
| Safari | 16+ |

### Container Style Queries — 부분 지원

`@container style()` 쿼리는 아직 부분적 지원 상태:

- **Chrome 111+, Edge 111+** — custom property 기반 스타일 쿼리 지원
- **Firefox, Safari** — 미지원 (Firefox는 2026년 내 지원 예상)

스타일 쿼리는 커스텀 프로퍼티 값에 따라 하위 요소 스타일을 조건부 적용하는 기능으로, 완전한 브라우저 지원 시 컴포넌트 테마링에 강력한 도구가 될 전망이다.

### calc-size() — 여전히 실험적

이 페이지에서 다룬 `calc-size()` 함수는 2026년 4월 기준 여전히 제한적 지원:

- **Chrome 129+, Edge 129+** — 지원 (2024-09부터)
- **Firefox, Safari** — 미지원

`auto`에서 고정 크기로의 애니메이션을 CSS만으로 처리하는 유일한 방법이지만, 프로덕션 사용 시 반드시 폴백이 필요하다.

## 관련 문서

- [[CSS Nesting]]
- [[CSS :has() 선택자]]
- [[CSS Anchor Positioning]]
