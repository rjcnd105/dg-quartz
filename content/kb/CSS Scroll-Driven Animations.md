---
publish: true
created: 2026-05-06T08:44:23Z
modified: 2026-05-06T08:44:23Z
tags:
  - kb
  - css
  - animation
  - frontend
---

CSS Scroll-Driven Animations는 keyframe animation의 progress를 시간(duration)이 아니라 scroll position이나 element visibility에 연결하는 CSS 기능이다. `animation-timeline`이 핵심 entry point이며, `view()`와 `scroll()` timeline을 통해 JavaScript 없이 scroll-linked animation을 만들 수 있다 (출처: [[Scroll-Driven Animations • Josh W. Comeau]]).

## 핵심 내용

전통적인 CSS animation은 `@keyframes`의 0%-100%를 시간에 mapping한다. Scroll-driven animation은 같은 keyframe percentage를 scroll progress에 mapping한다.

```css
@keyframes fadeIn {
  from { opacity: 0; }
  to { opacity: 1; }
}

.item {
  animation: fadeIn linear;
  animation-timeline: view();
}
```

`view()`는 element가 viewport/scrollport를 통과하는 정도를 timeline으로 사용한다. `scroll()`은 scroll container 자체의 scroll progress를 timeline으로 사용한다.

## Animation range

`animation-range`는 timeline 중 animation이 실제로 진행되는 구간을 제한한다.

```css
.item {
  animation: slideIn linear;
  animation-timeline: view();
  animation-range-start: cover 0%;
  animation-range-end: cover 50%;
}
```

`cover`는 element가 scrollport에 들어오기 시작해서 완전히 나갈 때까지의 범위이고, `contain`은 element가 fully visible인 구간을 기준으로 한다. `entry`, `exit` 같은 named range를 쓰면 appear/disappear 구간을 더 직접적으로 다룰 수 있다.

## Linked timelines

`view-timeline`으로 특정 element의 view progress timeline에 이름을 붙이면, 다른 element가 그 timeline을 구독할 수 있다.

```css
main {
  timeline-scope: --tracked;
}

.tracked {
  view-timeline: --tracked;
}

.indicator {
  animation: grow linear;
  animation-timeline: --tracked;
}
```

`timeline-scope`는 timeline name의 visibility boundary를 넓힌다. Track 대상과 animate 대상이 sibling처럼 서로 descendant 관계가 아닐 때 nearest shared ancestor에 선언한다.

## 주의점

- `animation` shorthand는 `animation-timeline`을 reset할 수 있으므로, 보통 `animation` 뒤에 `animation-timeline`을 둔다.
- Scroll-linked animation도 motion sensitivity를 고려해야 한다. `prefers-reduced-motion: reduce`에서 optional animation을 제거하거나 약화한다.
- Native CSS timeline은 scroll event listener나 IntersectionObserver 기반 JavaScript보다 main thread 부담을 줄일 수 있지만, browser support와 fallback은 target audience 기준으로 확인한다.

## 관련 링크

- [[CSS Partial Keyframes]] — keyframe composition과 dynamic keyframe reuse
- [[Fluid Responsive Design]] — interaction과 layout을 viewport breakpoint보다 intrinsic behavior 중심으로 설계
- [[CSS Container Queries]] — component context 기반 CSS primitive
- MDN: https://developer.mozilla.org/en-US/docs/Web/CSS/Guides/Scroll-driven\_animations
