---
publish: true
created: 2026-05-06T08:44:23Z
modified: 2026-05-06T08:44:23Z
tags:
  - kb
  - llm
  - agent
  - skill
  - architecture
  - security
---

Agent skill representation은 SKILL.md 같은 자연어-heavy artifact를 agent가 검색, 선택, 검토할 수 있는 source-grounded 구조로 바꾸는 문제다. SSL 논문은 이를 scheduling, structural, logical 세 layer로 나누는 중간 표현을 제안한다 (출처: [[From Skill Text to Skill Structure The Scheduling-Structural-Logical Representation for Agent Skills]]).

## 핵심 내용

현재 skill artifact는 invocation 조건, 실행 단계, tool/resource side effect가 한 문서 안에 섞여 있는 경우가 많다. 사람에게는 읽기 쉽지만 registry, router, policy checker, reviewer가 재사용하기에는 같은 사실을 매번 raw text에서 다시 추출해야 한다.

Scheduling-Structural-Logical(SSL) representation은 이 병목을 세 층으로 분리한다.

| Layer | 역할 |
|-------|------|
| Scheduling | skill name, goal, intent signature, expected input/output, dependency 같은 routing surface |
| Structural | preparation, action, verification, recovery 같은 scene-level execution phase |
| Logical | READ, WRITE, CALL\_TOOL, VALIDATE 같은 atomic action과 resource scope/effect |

논문에 따르면 SSL은 source artifact를 대체하는 표준이 아니라 source-adjacent evidence interface다. Structured view는 skill discovery와 risk review에서 필요한 신호를 앞으로 끌어내고, 원문은 guardrail, 예시, 의도, severity 판단 같은 맥락을 제공한다.

## 평가 신호

논문은 6,184개 public skill corpus와 403개 task-grounded query로 Skill Discovery를 평가했다. `Desc + SSL-Rich` 입력은 description-only baseline 대비 MRR을 0.573에서 0.707로 올렸다.

Risk Assessment에서는 500개 skill에 대해 data exfiltration, destructive behavior, privilege escalation, covert execution, resource abuse, credential access를 1-5 scale로 라벨링했다. `Full SKILL.md + SSL` view는 full text alone 대비 primary threshold macro F1을 0.744에서 0.787로 올렸다.

이 결과는 긴 원문을 더 많이 넣는 것보다, interface/scene/resource evidence를 비교 가능한 형태로 분리하는 것이 discovery와 review에 유리할 수 있음을 시사한다.

## 한계

SSL은 static artifact에서 추출된다. 동적으로 payload를 다운로드하거나 runtime condition에 따라 resource access가 달라지는 skill은 execution trace 없이 정확히 표현하기 어렵다. 또한 generated code의 runtime risk처럼 "skill이 직접 수행하지는 않지만 skill이 만든 code가 수행하는 위험"은 structured field가 과소평가할 수 있다.

따라서 실전에서는 SSL을 source document, runtime sandbox, permission manifest, review checklist와 함께 써야 한다.

## 관련 링크

- [[LLM Harness]] — skill을 로드하고 실행하는 주변 시스템
- [[AI Organisation]] — skill보다 큰 단위인 agent/talent 운영 layer
- [[Agent Task Verification]] — skill execution 후 완료 주장 검증
- [[File-as-Bus]] — skill side effect와 handoff가 파일 시스템에 남는 coordination pattern
