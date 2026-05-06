---
publish: true
created: 2026-04-08T03:15:00Z
modified: 2026-05-06T08:44:23Z
tags:
  - kb
  - css
  - animation
---

# CSS Partial Keyframes

`@keyframes` 정의에서 `from` 또는 `to` 블록을 생략하여, 생략된 값을 요소의 현재 컨텍스트에서 상속받는 기법이다. 단순한 코드 절약을 넘어 키프레임 애니메이션을 동적(dynamic)이고 조합 가능(composable)하게 만든다. (출처: [[Partial Keyframes • Josh W. Comeau]])

## 컨텍스트 상속

`from`을 생략하면 애니메이션의 시작값이 요소에 현재 적용된 CSS 값에서 상속된다. `to`를 생략해도 마찬가지로 현재 값이 종착점이 된다. (출처: [[Partial Keyframes • Josh W. Comeau]])

```css
/* from 생략: 현재 opacity에서 0으로 페이드 */
@keyframes fadeToTransparent {
  to { opacity: 0; }
}

/* to 생략: 0에서 현재 opacity로 페이드 */
@keyframes fadeFromTransparent {
  from { opacity: 0; }
}
```

기본 `opacity: 1`인 요소와 `opacity: 0.7`인 요소에 동일한 `fadeToTransparent`를 적용하면, 각각 1에서 0으로, 0.7에서 0으로 자연스럽게 페이드된다. 전통적인 `from { opacity: 1 }` 방식은 모든 요소가 1로 스냅한 후 페이드되어 부자연스럽다.

## 애니메이션 조합 (Composable Keyframes)

여러 키프레임 애니메이션이 같은 속성을 동시에 수정할 때, partial keyframes를 사용하면 하나가 다른 하나를 덮어쓰지 않고 합성된다. (출처: [[Partial Keyframes • Josh W. Comeau]])

```css
@keyframes twinkle {
  from { opacity: 0.25; }
  to { opacity: 0.75; }
}

@keyframes fadeFromTransparent {
  from { opacity: 0; }
}

.ball {
  animation:
    twinkle 250ms alternate infinite,
    fadeFromTransparent 2000ms;
}
```

`fadeFromTransparent`는 `to`가 없으므로 `twinkle`이 실시간으로 설정하는 opacity 값을 목표로 삼는다. 결과적으로 투명한 상태에서 점차 반짝이는 효과가 드러나는 합성 애니메이션이 된다.

## CSS 변수를 활용한 동적 키프레임

키프레임 정의 내에서 CSS 변수(`var()`)를 참조할 수 있다. 동일한 키프레임으로 요소마다 다른 진폭의 애니메이션을 적용할 수 있다. (출처: [[Partial Keyframes • Josh W. Comeau]])

```css
@keyframes oscillate {
  from { transform: translateX(calc(var(--amount) * -1)); }
  to { transform: translateX(var(--amount)); }
}
```

```html
<div class="ball" style="--amount: 8px"></div>
<div class="ball" style="--amount: 64px"></div>
```

과거에는 진폭마다 별도의 `@keyframes`를 정의하거나 JavaScript 인터벌과 CSS transition을 조합해야 했던 문제를 해결한다. CSS 변수 지원 이후(브라우저 지원율 ~96%) 사용 가능하다.

## 관련 문서

- [[CSS Nesting]]
- [[CSS Scroll-Driven Animations]]
