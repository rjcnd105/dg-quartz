---
publish: true
created: 2026-04-29T04:54:11Z
modified: 2026-05-07T03:26:38Z
tags:
  - kb
  - glossary
  - state-machine
---

Finite State Machine(FSM)은 시스템이 미리 정의된 상태 중 하나에 있고, event나 condition에 따라 허용된 transition만 수행하는 모델이다.

## 핵심 내용

FSM은 task lifecycle, UI state, protocol state를 명시적으로 관리할 때 유용하다. 예를 들어 task는 `pending -> processing -> completed -> accepted` 같은 상태를 거칠 수 있고, 실패하면 `failed`나 retry path로 전환될 수 있다.

핵심 가치는 "현재 가능한 상태 전이"를 제한해 illegal state를 줄이는 것이다.

## 구성 요소

- State: 현재 시스템이 속한 유한한 모드.
- Event: transition을 유발하는 입력.
- Transition: source state에서 target state로 이동하는 규칙.
- Guard: transition 허용 여부를 결정하는 조건.
- Action/effect: transition 중 실행되는 side effect.

## 실무 맥락

FSM은 UI flow, auth/session lifecycle, order status, protocol, workflow task state에 적합하다. 상태가 많아지고 parallel/hierarchical state가 필요하면 statechart가 더 적합하다. XState 같은 library는 FSM/statechart를 executable model로 만들어 테스트와 시각화를 쉽게 한다.

## 해석 경계

FSM은 entity 하나의 allowed transition을 명확히 하는 모델이지, dependency graph 전체를 정렬하는 모델은 아니다. 작업 간 선후관계는 [[DAG]], 각 작업의 lifecycle은 FSM으로 나누는 편이 깔끔하다.

## 관련 링크

- [[AI Organisation]] — OMC의 task lifecycle이 FSM으로 표현된다

## 관련 문서

- Stately/XState docs: https://stately.ai/docs
- SCXML W3C state machine notation: https://www.w3.org/TR/scxml/
