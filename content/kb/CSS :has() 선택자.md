---
publish: true
created: 2026-04-08T03:15:00Z
modified: 2026-04-08T03:15:00Z
tags:
  - kb
  - css
  - selectors
---

# CSS :has() 선택자

특정 자식 요소를 포함하거나, 특정 요소가 뒤따르는 부모/형제 요소를 선택할 수 있는 의사 클래스다. CSS만으로는 불가능했던 "부모 선택자" 역할을 수행하며, 과거에는 JavaScript나 서버 사이드 렌더링으로 처리해야 했던 패턴을 순수 CSS로 해결한다. (출처: [[Important CSS features web developers should know in 2025]])

## 사용 패턴

```css
/* span을 포함하는 button 선택 */
button:has(span) {
  background: red;
}

/* span이 바로 뒤에 오는 button 선택 (인접 형제 결합자) */
button:has(+ span) {
  background: orange;
}

/* label이 뒤에 오는 button 선택 (일반 형제 결합자) */
button:has(~ label) {
  background: purple;
}
```

## 핵심 포인트

- 자식 존재 여부에 따른 부모 스타일링 (`div:has(> img)`)
- 인접/일반 형제 결합자와 조합하여 "앞 요소" 선택 가능
- 폼 유효성 검사 UI, 조건부 레이아웃 등에 활용
- `:nth-child(N of selector)` 문법과 함께 사용하면 "특정 선택자에 매칭되는 N번째 자식"을 정확히 선택 가능 (출처: [[Important CSS features web developers should know in 2025]])

## :nth-child(N of selector)

과거에는 `.red:nth-child(3)`이 "3번째 `.red` 요소"가 아니라 "부모의 3번째 자식이면서 `.red`인 요소"를 선택했다. 이제 `:nth-child(3 of .red)` 문법으로 정확히 `.red` 중 3번째를 선택할 수 있다. `:nth-last-child`도 동일하게 동작한다. 모든 주요 브라우저에서 지원된다. (출처: [[Important CSS features web developers should know in 2025]])

```css
:nth-child(3 of .red) {
  border: 3px solid red;
}
```

## 관련 문서

- [[CSS Nesting]]
- [[CSS Container Queries]]
