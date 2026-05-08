---
publish: true
created: 2026-05-08T08:30:39Z
modified: 2026-05-08T08:30:39Z
tags:
  - kb
  - llm
  - agent
  - harness
  - architecture
---

Managed agent architecture는 agent의 brain, hands, session을 서로 교체 가능한 interface로 분리해 long-horizon agent를 더 안정적으로 운영하는 설계다.

## 핵심 내용

Anthropic의 Managed Agents 글은 agent system을 하나의 container에 묶는 방식의 한계를 "pet" 문제로 설명한다. Session, harness, sandbox가 한 container에 같이 있으면 container failure가 session loss로 이어지고, debugging도 user data와 섞여 어려워진다 (출처: [[Scaling Managed Agents Decoupling the brain from the hands]]).

해법은 세 component를 분리하는 것이다.

- **Brain**: Claude와 [[LLM Harness]]가 있는 orchestration layer.
- **Hands**: sandbox, tool, MCP server처럼 실제 action을 수행하는 실행 환경.
- **Session**: append-only event log. Context window 밖에 durable하게 존재한다.

이 구조에서 sandbox는 `execute(name, input) -> string` 형태의 tool이 되고, 필요할 때 `provision({resources})`로 새로 만들 수 있다. Harness도 session log 밖에 상태를 숨기지 않으므로 crash 후 `wake(sessionId)`와 `getSession(id)`로 복구할 수 있다.

## 보안 경계

중요한 설계 포인트는 credential이 generated code가 실행되는 sandbox 안에 노출되지 않는다는 점이다. Git access token은 clone/push/pull이 가능하도록 remote에 묶이지만 agent가 token string을 직접 읽지 않는다. Custom tool은 MCP proxy와 vault를 통해 session-associated credential을 사용한다. 즉 token은 hand가 아니라 resource/vault boundary에 붙는다.

## Session은 context window가 아니다

Session log는 Claude의 context window와 다르다. Context window는 현재 prompt에 들어가는 제한된 working set이고, session은 전체 event stream의 durable store다. Harness는 `getEvents()`로 필요한 slice를 가져와 재구성할 수 있다. 이 분리는 compaction이나 trimming이 틀렸을 때도 원본 event를 회복할 수 있게 한다.

## 관련 링크

- [[LLM Harness]] — brain 쪽 orchestration code
- [[Agent Memory Systems]] — session log와 context object가 memory로 쓰이는 방식
- [[Faithful Uncertainty]] — agent가 언제 tool을 써야 하는지 판단하는 control signal
- [[Deterministic Routing]] — 요청과 ownership을 안정적으로 묶는 분산 시스템 패턴
