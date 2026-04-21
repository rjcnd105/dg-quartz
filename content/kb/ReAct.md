---
publish: true
created: 2026-04-17T08:00:00Z
modified: 2026-04-17T08:00:00Z
tags:
  - kb
  - llm
  - agent
  - glossary
---

Reasoning + Acting. LLM이 thought → action → observation 사이클을 반복하여 외부 도구와 상호작용하는 에이전트 패러다임.

## 핵심 내용

한 턴의 모델 응답은 "생각하는" 텍스트(`<think>...`)와 "행동"(`<tool_call>...` 또는 `<answer>...`)으로 나뉘고, 도구 실행 결과(observation)가 다음 턴의 입력에 추가된다. 목표는 다단계 추론을 도구 호출과 맞물려 진행하는 것.

전형적 루프:

1. **Thought** — 현재 상태 분석
2. **Action** — 도구 호출 또는 최종 답 생성
3. **Observation** — 도구 응답을 컨텍스트에 append
4. 반복

[[Memory Intelligence Agent (MIA)]]의 Executor가 plan 지침 아래 ReAct 루프를 따라 도구(검색, 이미지 조회)를 호출한다 (출처: [[Memory Intelligence Agent]]).

## 관련 링크

- [[Memory Intelligence Agent (MIA)]] — Planner가 생성한 plan을 ReAct로 실행
- [[Agent Memory Systems]] — ReAct trajectory가 메모리의 기본 단위
- 원 논문: Yao et al., "ReAct: Synergizing Reasoning and Acting in Language Models" (2023)
