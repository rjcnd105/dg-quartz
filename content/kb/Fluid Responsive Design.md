---
publish: true
created: 2026-04-23T00:00:00Z
modified: 2026-04-23T00:00:00Z
tags:
  - kb
  - css
  - responsive-design
  - frontend
---

반응형 디자인을 **viewport breakpoint 중심**에서 **intrinsic·component-first 유동 시스템**으로 이동하는 접근. Breakpoint는 제거 대상이 아니라 환경·사용자 선호 감지의 도구로 재배치된다 (출처: [[Building a UI Without Breakpoints]]).

## 왜 breakpoint-first가 퇴조하는가

- 화면 다양성 증가 — 어느 viewport width를 타깃할지 결정이 moving guess.
- 같은 컴포넌트가 full-width feed, 좁은 sidebar, modal, dashboard tile에 **중첩·재사용**되는 것이 현실. Viewport 기반 규칙은 컨테이너 상이로 불일치를 낳는다.
- 대부분의 "responsive 변화"는 **구조 pivot이 아니라 scalar tuning** (space·density·typography). Breakpoint-first는 이를 discrete jump로 강제하여 긴 override chain 유발.

## 네 가지 primitive

### 1. Intrinsic Layouts

Breakpoint로 column 수를 강제하지 말고 **제약만 선언**하고 브라우저가 파생하게:

```css
.with-auto-fit {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
  gap: 1em;
}
```

두 영역(sidebar + main):

```css
body { display: flex; flex-wrap: wrap; }
main { flex: calc(infinity) 1 360px; }
aside { flex: 1 1 240px; }
```

`calc(infinity)`가 priority·grow 의도를 선언하여 hard switch를 smoother flow로 대체.

### 2. Fluid Values (`clamp()`)

Scalar 조정(타이포, 간격, radius)은 discrete 대신 continuous:

```css
.fluid-card {
  font-size: clamp(16px, calc(11.529px + 1.176vi), 20px);
  padding: clamp(1em, calc(-0.118em + 4.706vi), 2em);
}
```

값 계산: clamp calculator 사용 (https://clamp-calculator.netlify.app/).

### 3. Container Units

컴포넌트 실제 렌더 크기 기반 단위. `container-type: inline-size` 등록 후 `cqi`, `cqb`, `cqmin`, `cqmax` 사용:

```css
.card-container { container-type: inline-size; }

.card {
  font-size: 5cqi;
  border-radius: clamp(4px, calc(-16.87px + 6.522cqi), 64px);
}

.card-content {
  flex: calc(infinity) 1 40cqi;
}
```

같은 CSS·세 컨테이너 크기 → 서로 다른 결과. Viewport 몰라도 portable.

### 4. Container Queries (구조 변경 전용)

Scalar가 아닌 **진짜 구조 변화**(레이아웃 재배열·요소 숨김)만 container query로:

```css
.container { container-type: inline-size; }

.group {
  display: flex;
  flex-direction: column;
  gap: 1em;

  @container (max-width: 32em) {
    flex-direction: row;
    gap: 0.5em;
    .icon { font-size: 1.5em; }
    p { display: none; }
  }
}
```

"How much space does this component have right now?" 질문이 viewport 질문을 대체. [[CSS Container Queries]] 참조.

## Media Query 재정의

`@media`는 **viewport 측정 도구에서 환경·사용자 선호 감지 도구**로:

```css
@media (hover: hover) { … }
@media (pointer: coarse) { … }
@media (display-mode: picture-in-picture) { … }
@media (update: slow) { … }
@media (scripting: none) { … }

@media (prefers-color-scheme: dark) { … }
@media (prefers-contrast: more) { … }
@media (prefers-reduced-motion: no-preference) { … }
@media (prefers-reduced-data: reduce) { … }
```

"Preferences"는 cosmetic choice가 아니라 **접근성 요구**. UI는 이를 존중해야.

## 실전 마이그레이션 체크리스트

1. **기존 media query 감사** — scalar 변경 vs 구조 변경 분리.
2. **Scalar branch 먼저 치환**: `clamp()`, `min()`, `max()` 토큰으로 이동.
3. **레이아웃을 intrinsic primitive로**: `auto-fit` + `minmax()`.
4. **컴포넌트 단위로 scope**: `container-type` 부여, container units 도입.
5. **구조 변화에만 container query**: threshold를 컴포넌트 내부에 둔다.
6. **Media query는 환경·선호에**: `hover`, `pointer`, `prefers-reduced-motion`, `update`.
7. **실제 placement 검증**: 사이드바·모달·full-content에서 동일 컴포넌트 테스트.

한 번에 전체 rewrite 필요 없음. 컴포넌트 단위 점진 이동.

## 최신 동향 (2026-04)

Container queries·container units·`clamp()` 모두 Baseline 안정. `calc-size()`는 아직 Chrome/Edge 전용(129+), Firefox/Safari 미지원이라 폴백 필요. 상세는 [[CSS Container Queries]]의 최신 동향 섹션.

## 관련 링크

- [[CSS Container Queries]] — 본 글의 Method 4. 구조 변화 전용 tool
- [[CSS Anchor Positioning]] — 컴포넌트 기반 레이아웃 철학과 정합
- [[CSS :has() 선택자]] — 선언적 조건 스타일. Container query와 함께 "컨텍스트-반응" CSS 축
- [[CSS Nesting]] — container query·media query 내부 중첩으로 의도 명확화
- [[CSS Partial Keyframes]] — fluid·intrinsic 접근과 맥락 인접
- 원문: https://frontendmasters.com/blog/building-a-ui-without-breakpoints/
- clamp calculator: https://clamp-calculator.netlify.app/
