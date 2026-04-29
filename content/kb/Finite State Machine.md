---
publish: true
created: 2026-04-29T04:54:11Z
modified: 2026-04-29T04:54:11Z
tags:
  - kb
  - glossary
  - state-machine
---

Finite State Machine(FSM)은 시스템이 미리 정의된 상태 중 하나에 있고, event나 condition에 따라 허용된 transition만 수행하는 모델이다.

## 핵심 내용

FSM은 task lifecycle, UI state, protocol state를 명시적으로 관리할 때 유용하다. 예를 들어 task는 `pending -> processing -> completed -> accepted` 같은 상태를 거칠 수 있고, 실패하면 `failed`나 retry path로 전환될 수 있다.

핵심 가치는 "현재 가능한 상태 전이"를 제한해 illegal state를 줄이는 것이다.

## 관련 링크

- [[AI Organisation]] — OMC의 task lifecycle이 FSM으로 표현된다
