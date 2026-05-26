---
publish: true
created: 2026-04-08T03:20:00Z
modified: 2026-05-07T03:26:38Z
tags:
  - kb
  - glossary
---

Abstract Syntax Tree. 소스 코드의 구조를 트리 형태로 표현한 것이다. 코드의 문법적 구조만 남기고 괄호, 세미콜론 같은 구문적 장식은 제거한다.

## 왜 사용하는가

코드를 문자열 그대로 다루면 구조를 파악하기 어렵다. AST로 변환하면 "이 함수의 인자가 몇 개인지", "if 블록 안에 어떤 문장이 있는지" 같은 질문에 트리 탐색으로 답할 수 있다. 코드 분석(linting), 변환(transpiling), 포매팅, 리팩토링 도구의 핵심 기반이다.

## Concrete syntax tree와 차이

Concrete syntax tree(parse tree)는 source token과 grammar production을 더 충실히 보존한다. AST는 tooling이 쓰기 쉬운 의미 구조만 남기기 때문에, formatting token이나 괄호 같은 구문 장식은 생략되거나 node attribute로만 남을 수 있다.

## tree-sitter

tree-sitter는 증분(incremental) 파싱을 지원하는 파서 생성기로, 코드가 수정될 때마다 전체를 다시 파싱하지 않고 변경된 부분만 업데이트한다. 에디터 구문 강조, 코드 네비게이션, AI 기반 코드 분석 등에 널리 사용된다.

## 실무 맥락

AST 기반 도구는 string replace보다 안전하지만, language grammar와 parser version에 묶인다. TypeScript, Babel, tree-sitter, compiler API마다 node shape가 다르므로 transform을 만들 때는 해당 parser의 schema와 location/range 정보를 기준으로 다뤄야 한다.

## 관련 문서

- [[Knowledge Graph Extraction]] — AST 기반 코드 구조 추출
- tree-sitter: https://github.com/tree-sitter/tree-sitter
- TypeScript compiler API: https://github.com/microsoft/TypeScript/wiki/Using-the-Compiler-API
