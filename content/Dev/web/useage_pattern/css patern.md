---
{"publish":true,"created":"2024-05-21T06:31:53Z","modified":"2025-10-20T04:43:31Z","tags":["c","s","s"],"cssclasses":""}
---


#### 자동 grid

grid-cols-[repeat(auto-fill,minmax(102px,1fr))]

#### 아코디언

grid를 이용하면 height auto에 해당하는 애니메이션을 쉽게 줄 수 있다.

li > div[inert] { grid-template-rows: 0fr; }
li > div { grid-template-rows: 1fr; transition: grid-template-rows .3s; }

#### 완벽한 중앙 배치를 위한 텍스트 사이즈 컴팩트하게 잡기

```css
.text {  text-box: cap alphabetic;}
```

#### 커서가 있는 경우에만 hover 효과 적용

모바일에서 hover effect가 롱프레스-취소시 풀리지 않는 문제를 수정하기 위함.

```css
 @media (hover: hover) and (pointer: fine) {
	&:hover {
	  background-color: #dfe3e8;
	}
 }
```

#### 리퀴드 글래스 css 지원시 적용

```css
@supports (-apple-visual-effect: -apple-system-glass-material) {
	.toolbar {
		background: transparent;
		-apple-visual-effect: -apple-system-glass-material;
	}
}

```

#### popover 사이드 바 고정

https://x.com/jh3yy/status/1977517175285154015

```css
.layout:has(:popover-open) {
	grid-template-columns: var(--sidebar-width) 1fr;
}
aside:popover-open {
	translate: 0 var(--ctrl);
	height: var(--extend);
}
```
