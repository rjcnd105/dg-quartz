---
publish: true
created: 2026-04-08T03:15:00Z
modified: 2026-04-08T03:20:00Z
tags:
  - kb
  - css
  - positioning
---

# CSS Anchor Positioning

한 요소(positioned element)를 다른 요소(anchor element)를 기준으로 배치하는 CSS 기능이다. 툴팁, 팝오버, 드롭다운 등 앵커 기반 UI를 순수 CSS로 구현할 수 있다. 과거에는 앵커 내부에 위치 요소를 넣거나 JavaScript로 위치를 계산해야 했다. 실험적 기능으로 브라우저 지원이 제한적이다. (출처: [[Important CSS features web developers should know in 2025]])

## 기본 문법

앵커 요소에 이름을 등록하고, 위치 요소에서 `anchor()` 함수로 앵커의 좌표를 참조한다.

```css
.anchor-element {
  anchor-name: --some-unique-anchor;
}

.positioned-element {
  position-anchor: --some-unique-anchor;
  position: absolute;
  left: calc(anchor(right) + 10px);
  top: calc(anchor(bottom) + 10px);
}
```

## @position-try 폴백

위치 요소가 뷰포트나 스크롤 영역을 벗어날 때 대체 위치를 지정하는 규칙이다. 오버플로우 상황을 CSS만으로 처리할 수 있다. (출처: [[Important CSS features web developers should know in 2025]])

```css
@position-try --top-left {
  position-area: top left;
  right: calc(anchor(left) + 10px);
  bottom: calc(anchor(top) + 10px);
}

@position-try --bottom-right {
  position-area: bottom right;
  left: calc(anchor(right) + 10px);
  top: calc(anchor(bottom) + 10px);
}

.tooltip {
  position-anchor: --someAnchor;
  position-try-fallbacks: --top-left, --bottom-right;
}
```

여러 폴백 위치를 순서대로 시도하여, 뷰포트 안에 들어오는 첫 번째 위치를 자동 선택한다.

## 최신 동향 (2026-04)

### 브라우저 지원 현황

2026년 초 기준으로 CSS Anchor Positioning이 모든 주요 브라우저에서 지원된다:

| 브라우저 | 지원 시작 버전 |
|---------|-------------|
| Chrome | 125+ |
| Edge | 125+ |
| Safari | 26+ |
| Firefox | 147+ |

2026년 1월부터 최신 브라우저 전반에서 작동하며, **프로덕션 사용이 가능한 수준**에 도달했다. 이전에 "실험적 기능"으로 분류되었지만 이제 Baseline 기능이 되었다.

### 폴리필

지원하지 않는 구형 브라우저를 위해 Oddbird가 관리하는 CSS Anchor Positioning polyfill이 JavaScript 폴백을 제공한다.

### @scope와 함께 프로덕션 레디

Anchor positioning과 `@scope`가 2026년 기준 프로덕션 레디 상태로, 새 프로젝트에서 JavaScript 기반 포지셔닝 라이브러리(Popper.js, Floating UI 등)의 대안으로 고려할 수 있다.

## 관련 문서

- [[CSS Container Queries]]
