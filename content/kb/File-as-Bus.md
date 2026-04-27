---
publish: true
created: 2026-04-17T09:00:00Z
modified: 2026-04-27T03:39:39Z
tags:
  - kb
  - glossary
  - agent
  - coordination
---

Multi-agent coordination 프로토콜. 대화·메시지가 아니라 **파일 시스템 자체가 coordination bus**. agent 간 handoff는 파일 쓰기·읽기로 이루어짐.

## 대비

| 전통 방식 | File-as-Bus |
|----------|-------------|
| 대화/메시지로 state 전달 | 파일로 state 전달 |
| agent 간 conversation context 공유 | workspace만 공유, context 각자 관리 |
| Context 누적 → token 팽창 | 파일 읽기로 on-demand 접근 |
| Handoff 시 state 손실·요약 | Durable artifact로 무손실 |

## 속성

- **System of record**: workspace가 유일한 진실 원천. 대화 log는 참조용
- **Progressive disclosure**: 파일 map → 필요한 파일만 read
- **Permission-scoped**: agent는 자기 역할에 맞는 영역만 write
- **Append-only logs**: 실험 로그 등은 덮어쓰기 금지. 이력 보존

## 등장 맥락

[[AiScientist]] (Chen et al., 2026)에서 명명. Long-horizon ML 연구 엔지니어링에서 대화 handoff의 한계를 극복하는 핵심 메커니즘.

유사 개념: Unix 파이프라인(파일·stdin/stdout 통한 프로세스 간 coordination), make 빌드 시스템(파일 타임스탬프로 의존성 추적). LLM agent 시대의 재발견.

[[Autogenesis Protocol]]의 AGS도 Orchestrator가 `plan.md` artifact를 versioned resource로 등록하고 sub-agent가 shared memory에 trace를 쓰는 구조를 사용한다. 차이는 File-as-Bus가 coordination substrate를 강조하는 반면, Autogenesis는 prompt/tool/memory/environment의 lifecycle과 rollback protocol을 강조한다.

## 실무 의미

- agent 개입 실패·재시작 내성 — 현재 workspace state에서 re-enter
- debugging 가능 — 모든 handoff가 파일로 검사 가능
- context window 독립 — state 크기가 모델 context 한계에 묶이지 않음
