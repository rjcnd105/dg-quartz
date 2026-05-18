---
publish: true
created: 2026-05-18T06:06:55Z
modified: 2026-05-18T06:06:55Z
tags:
  - kb
  - llm
  - agent
  - research
  - memory
---

Personalized research automation agents는 autonomous research pipeline이 topic만 처리하는 것이 아니라, 연구자별 resource, preference, output style, history를 장기적으로 반영해야 한다는 설계 축이다.

## 핵심 내용

NanoResearch 논문은 research automation의 병목을 "pipeline을 끝낼 수 있는가"보다 "누구를 위한 automation인가"로 재정의한다 (출처: [[NanoResearch Co-Evolving Skills, Memory, and Policy for Personalized Research Automation]]). 제안 구조는 세 층이 함께 진화한다.

| 층 | 역할 |
|----|------|
| Skill bank | 반복되는 procedural rule과 debugging strategy를 compact skill로 저장 |
| Memory module | user/project-specific history, failed hypotheses, constraints를 유지 |
| Policy learning | free-form feedback을 planner parameter update로 내재화 |

논문의 핵심 주장은 skill, memory, planner policy가 따로 있으면 부족하다는 것이다. Skill은 general procedure를 주지만 사용자 맥락이 없고, memory는 맥락을 주지만 실행 규칙이 없으며, preference alignment가 없으면 implicit preference가 context 밖으로 사라진다.

## 해석 경계

평가는 LLM-simulated scientist와 자동 judge가 많이 들어간다. 따라서 "실제 연구자가 장기간 쓰면 같은 개선이 난다"는 결론은 아직 약하다. 그러나 agent architecture 관점에서는 [[Agent Memory Systems]]의 process-oriented memory, [[Agent Skill Representation]]의 reusable skill interface, [[Native Agent Evolution]]의 self-evolution 흐름을 research automation domain에 통합한 사례로 볼 수 있다.

## 관련 링크

- [[Agent Memory Systems]] — memory format과 process-oriented retrieval
- [[Agent Skill Representation]] — natural-language skill을 구조화하는 문제
- [[AiScientist]] — long-horizon ML research engineering agent
- [[Native Agent Evolution]] — task 전 environment knowledge 생성
- [[Self-Evolving Code]] — codebase 자체를 evolutionary loop에 넣는 접근
