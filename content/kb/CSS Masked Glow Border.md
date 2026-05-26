---
publish: true
created: 2026-04-29T04:54:11Z
modified: 2026-04-29T04:54:11Z
tags:
  - kb
  - css
  - frontend
  - animation
---

CSS masked glow border는 `background-image`를 여러 mask layer로 잘라내고, pointer 위치에 따라 `conic-gradient` 시작 각도를 갱신해서 카드 테두리 주변의 glow가 포인터를 따라오는 것처럼 보이게 하는 패턴이다 (출처: [[Post by @jh3yy on X]]).

## 핵심 내용

패턴의 중심은 decorative border를 실제 border로 그리는 것이 아니라, pseudo-element나 overlay의 background를 mask로 잘라낸 뒤 blur 처리하는 것이다.

구성 요소:

- `mask` 또는 `mask-image`: transparent layer와 `conic-gradient` layer를 함께 사용
- `mask-clip: padding-box, border-box`: mask layer가 padding/border box에 맞춰 적용되도록 분리
- `mask-composite: intersect`: 여러 mask layer의 교집합만 남김
- scoped custom properties: `--start`, `--spread`, `--blur` 같은 값으로 각 카드별 상태 관리
- `pointermove`: 카드 중심과 pointer 좌표의 angle을 계산해 `conic-gradient(from ...)`에 주입

## 구현 흐름

1. 각 카드의 center point를 계산한다.
2. `pointermove`에서 pointer와 center 사이의 각도를 `Math.atan2`로 구한다.
3. 음수 angle은 `+360`으로 0-360 범위에 맞춘다.
4. 해당 angle을 카드의 custom property로 저장한다.
5. CSS mask의 `conic-gradient(from ...)`가 그 값을 읽어 glow 방향을 바꾼다.
6. pointer가 카드 주변의 proximity threshold 안에 있을 때만 opacity를 올린다.

```js
const angle = Math.atan2(
  event.y - cardCenter[1],
  event.x - cardCenter[0]
) * 180 / Math.PI;

card.style.setProperty("--start", `${angle < 0 ? angle + 360 : angle + 90}`);
```

```css
.glow {
  mask-clip: padding-box, border-box;
  mask-composite: intersect;
  mask:
    linear-gradient(#0000, #0000),
    conic-gradient(
      from calc((var(--start) - (var(--spread) * 0.5)) * 1deg),
      #0000 0deg,
      #fff,
      #0000 calc(var(--spread) * 1deg)
    );
}

.glows {
  filter: blur(calc(var(--blur) * 1px));
}
```

## 설계 기준

- Glow는 content box 위에 직접 얹지 말고 pseudo-element/overlay로 분리한다.
- Pointer proximity threshold를 둔다. 모든 카드 glow를 항상 켜면 visual noise와 paint cost가 커진다.
- Card별 custom property를 쓰면 global state 없이 각 카드의 angle/spread/opacity를 조절할 수 있다.
- `pointermove`에서 layout read를 매번 반복하지 않도록 card bounds는 resize/scroll 시점에 갱신하는 편이 낫다.
- Accessibility상 hover-only affordance에 중요한 정보를 싣지 않는다. Glow는 decorative feedback이어야 한다.

## 최신 동향 (2026-04)

`mask-composite`는 MDN 기준 Baseline 2023 기능이며, 2023년 12월부터 최신 device/browser에서 작동한다. MDN 페이지는 2026-04-20 수정 기준으로 `add`, `subtract`, `intersect`, `exclude` 값을 문서화한다. 따라서 2023년 clipping의 legacy fallback(`source-in`, `xor`)은 오래된 browser target이 있을 때만 고려하면 된다.

## 관련 링크

- [[CSS Style Scoping]] — card component 내부 style boundary와 연결
- [[CSS Container Queries]] — card 크기 기반 variant 조절에 사용 가능
- [[CSS Partial Keyframes]] — 현재 값에서 시작하는 animation composition 패턴
- MDN: https://developer.mozilla.org/en-US/docs/Web/CSS/Reference/Properties/mask-composite
