---
publish: true
created: 2026-04-08T03:15:00Z
modified: 2026-04-08T03:15:00Z
tags:
  - kb
  - css
---

# CSS Nesting

CSS 선택자를 중첩하여 작성할 수 있는 네이티브 기능이다. 과거에는 SASS, LESS 등 전처리기를 통해서만 가능했던 중첩 선택자를 이제 브라우저가 직접 지원한다. 2023년 말부터 모든 주요 브라우저에서 완전히 지원된다. (출처: [[Important CSS features web developers should know in 2025]])

## 문법

`&`는 부모 선택자를 참조한다. 자식 선택자는 `&` 없이 직접 중첩할 수 있고, 부모를 다른 선택자의 자식으로 배치하려면 `부모선택자 &` 형태를 사용한다.

```css
button {
  background: red;

  &.blue {
    background: blue;
  }

  span {
    text-decoration: underline;
  }

  div & {
    border: 3px solid green;
  }
}
```

## 장점

- 코드 구조가 HTML 구조와 일치하여 가독성 향상
- 선택자 반복이 줄어 CSS 파일 크기 감소 (로딩 시간, 네트워크 대역폭 절약)
- 전처리기 의존성 제거

## 관련 문서

- [[CSS :has() 선택자]]
- [[CSS Container Queries]]
