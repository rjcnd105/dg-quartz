---
publish: true
created: 2026-01-19T01:29:29Z
modified: 2026-03-19T07:25:23Z
tags:
  - ai
  - llm
  - agents
  - claude
cssclasses: ""
---


AI를 잘 사용하기 위한 나의 지식들

## 인간의 개입 최소화

인간이 최대의 병목이다.
AI는 몇 초의 시간이면 PM - 디자이너 - 개발자 간에 방대한 양의 동일한 context를 전달할 수 있지만, 사람은 몇 시간, 몇 일이 걸리기도 하며 정확성도 떨어진다.
그러므로 사람의 개입은 최소화하는 방향으로 점진적으로 구축해나가야 한다.

[클로드 코드 작동 방식](https://medium.com/@boredhead/context-skills-hooks-subagents-how-claude-code-actually-works-acdbb7baef6a)
[클로드 코드의 10단계 참고](https://github.com/darnoux/claude-code-level-up)
[클로드 코드 장편 가이드](https://x.com/affaanmustafa/status/2014040193557471352)

인간은 인간이 역할이 최소화될 수 있게끔하는 시스템을 점진적으로 구축 해야한다.
에이전트가 스스로 개선할 수 있는 자기 개선 루프를 만들어라.

## Skills

[공식 가이드](https://code.claude.com/docs/en/skills)
[스킬 실전 활용법](https://x.com/trq212/status/2033949937936085378)

## Hooks

[공식 가이드](https://code.claude.com/docs/en/hooks-guide)

## Agents

역할별로 구분하여 특화시키고, 역할에 맞는 권한을 부여해라.
특정 Skill, Hooks 등을 해당 에이전트의 Context내에서 사용하게끔 하라. (토큰 절약 + 역할 특화)
그리고 subagents 들이 서로 간에 공유할 수 있는 창구를 만들어라 (file, db)

[공식 가이드](https://code.claude.com/docs/ko/sub-agents)

### Master subagents

worker subagents 들을 역할에 따라 만들고 조율하는 subagent. 에이전트 오케스트레이터
kubernetes의 master node 역할

### Worker subagents

특정 맥락 내에서 특정 역할을 수행하는 도구성 에이전트
kubernetes의 worker node 역할

## Plugins

claude 구성(skill, hooks, Agents, Instruction, ... 등)을 묶은 단위라고 생각하면 된다.

[공식 제작 가이드](https://code.claude.com/docs/en/plugins)
[공식 플러그인 디렉토리](https://github.com/anthropics/claude-plugins-official)

## Harness

lint들을 설정하고 lint 내용은 지침에서 제외하고 workflow로 설정하라.
에이전트가(특히 subagent) 특정 스키마에 해당하는 결과 값을 내뱉도록 제한함으로써 검증 가능하도록 해라.

https://openai.com/ko-KR/index/harness-engineering/

harness를 프로그래밍 방식으로 구축하는 관련 라이브러리
 [deepagents](https://github.com/langchain-ai/deepagents)
 [pydantic AI](https://ai.pydantic.dev/)
[claude sdk 사용](https://platform.claude.com/docs/en/agent-sdk/overview)

관련 연구 자료
[AutoHarness](https://arxiv.org/abs/2603.03329)

## 재귀적 자기 개선 루프

에이전트가 자신이 실행한 세션들을 기록하여 사용자의 피드백과 함께 회고하고 그것이 더 나은 에이전트를 만들게끔 하는 재귀적 자기 개선 루프를 설정하라.
인간이 필요 없어지는 그날까지..

[클로드 코드와 함께한 건축 과정](https://shawnos.ai/blog/6-weeks-of-building-with-claude-code)
[스스로 발전하는 에이전트 만들기](https://medium.com/@nomannayeem/lets-build-a-self-improving-ai-agent-that-learns-from-your-feedback-722d2ce9c2d9)

관련 라이브러리
[hindsight](https://github.com/vectorize-io/hindsight)

관련 연구 자료
[Efficient Lifelong Memory for LLM Agents](https://arxiv.org/html/2601.02553v1)
[Lifelong Learning of Large Language Model based Agents](https://arxiv.org/html/2501.07278v1)
[A Survey on the Memory Mechanism of Large Language Model-based Agents](https://dl.acm.org/doi/10.1145/3748302)

