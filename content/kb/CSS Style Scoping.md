---
publish: true
created: 2026-04-27T03:33:23Z
modified: 2026-04-29T04:54:11Z
tags:
  - kb
  - css
  - frontend
  - architecture
---

CSS style scoping은 component 내부 class name이 global stylesheet에서 충돌하지 않도록 selector 적용 범위를 제한하는 문제다. Chris Coyier는 name-only container와 `@scope`가 build tool 없이 이 문제를 일부 풀 수 있다고 설명한다 (출처: [[Name-Only Containers The Scoping We Needed]]).

## 핵심 내용

대규모 component system에서는 서로 다른 component가 `.title`, `.button`, `.content` 같은 자연스러운 class name을 공유하기 쉽다. CSS Modules, Vue `<style scoped>`, Svelte scoped style은 build step으로 selector를 변형해 충돌을 방지한다.

Name-only container 접근은 component root에 고유한 `container-name`을 부여하고, component stylesheet를 조건 없는 `@container <name>` 블록 안에 넣는다.

```css
ds-card {
  container-name: ds-card;
}

@container ds-card {
  .title {
    font-weight: 600;
  }
}
```

이 방식은 container size 조건을 보려는 것이 아니라 **container name을 lexical scope처럼 쓰는 것**이다. `container-type: inline-size` 없이도 작동할 수 있지만, browser support와 side effect는 구현별 확인이 필요하다.

`@scope`는 같은 목적을 더 직접적으로 표현한다.

```css
@scope (ds-card) {
  .title {
    font-weight: 600;
  }
}
```

Coyier는 update에서 `@scope`가 이 use case에 더 aligned 하고 browser support도 더 깊다고 정정한다. 따라서 name-only container는 "container query로 scoping도 가능하다"는 흥미로운 패턴이고, 일반적인 scoped style 의도에는 `@scope`가 더 명확한 선택일 수 있다.

## 설계 기준

- Component root가 이미 고유한 이름을 갖는 design system에서는 root selector를 scope boundary로 쓰는 편이 자연스럽다.
- Scoping만을 위해 selector nesting으로 specificity를 올리는 것은 장기 유지보수 비용을 만든다.
- Build-time scoped CSS가 이미 있는 framework에서는 native scoping 전환의 이익과 browser target을 먼저 비교해야 한다.

## 관련 링크

- [[CSS Container Queries]] — name-only container가 기대는 `@container` 메커니즘
- [[Fluid Responsive Design]] — component-first CSS 설계와 연결
- [[CSS Nesting]] — scoping을 흉내 내는 nested selector와 specificity trade-off
- [[CSS Masked Glow Border]] — card component 내부 custom property와 pseudo-element로 decorative effect를 격리하는 예
