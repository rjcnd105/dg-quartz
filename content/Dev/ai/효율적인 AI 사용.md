---
publish: true
created: 2026-01-19T01:29:29Z
modified: 2026-03-26T07:20:01Z
tags:
  - ai
  - llm
  - agents
  - claude
cssclasses: ""
---


AI를 잘 사용하기 위한 나의 지식들

## 개요

[클로드 코드 작동 방식](https://medium.com/@boredhead/context-skills-hooks-subagents-how-claude-code-actually-works-acdbb7baef6a)
[클로드 코드 장편 가이드](https://x.com/affaanmustafa/status/2014040193557471352)
[2026년에 실제로 효과가 있는 프롬프트 기법 30가지](https://x.com/zodchiii/article/2036093004725747955)
[클로드 코드 모범 사례: 도구에서 시스템으로](https://x.com/Voxyz_ai/article/2036863425905586265)

### 세부화된 파일 참조

함수, 모듈을 분리하여 import 하듯이 agents 지침도 세분화하여 한번에 많은 context를 불러오지 않게끔 하는 것이 아주 중요하다.
[.claude/ 폴더의 구조](https://x.com/akshay_pachaar/article/2035341800739877091)

### 인간의 개입 최소화 추구

인간이 최대의 병목이다.
AI는 몇 초의 시간이면 PM - 디자이너 - 개발자 간에 방대한 양의 동일한 context를 전달할 수 있지만, 사람은 몇 시간, 몇 일이 걸리기도 하며 정확성도 떨어진다.
그러므로 사람의 개입은 최소화하는 방향으로 점진적으로 구축해나가야 한다.

[클로드 코드의 10단계 참고](https://github.com/darnoux/claude-code-level-up)

인간은 인간이 역할이 최소화될 수 있게끔하는 시스템을 점진적으로 구축 해야한다.
에이전트가 스스로 개선할 수 있는 [[Dev/ai/효율적인 AI 사용#재귀적 자기 개선 루프]]를 만들어라.

## Skills

에이전트가 사용하는 도구
 context 주입, 이번 메세지에서 높은 우선순위로 강력히 따르게 
cli나 bash, scripts격에 해당하는 도구들과 결합되면 더욱 강력하다. (일종의 harness + context 절약)

[공식 가이드](https://code.claude.com/docs/en/skills)
[스킬 실전 활용법](https://x.com/trq212/article/2033949937936085378)

## Hooks

특정 event 상황에서 실행되는 콜백

[공식 가이드](https://code.claude.com/docs/en/hooks-guide)

## SubAgents

역할별로 구분하여 특화시키고, 역할에 맞는 권한을 부여해라.
특정 Skill, Hooks 등을 해당 에이전트의 Context내에서 사용하게끔 하라. (토큰 절약 + 역할 특화)
그리고 subagents 들이 서로 간에 공유할 수 있는 창구를 만들어라 (file, db)

[공식 가이드](https://code.claude.com/docs/ko/sub-agents)

### Master(main) subagents

worker subagents 들을 역할에 따라 만들고 조율하는 subagent. 에이전트 오케스트레이터
kubernetes의 master node 역할

### Worker(sub) subagents

특정 맥락 내에서 특정 역할을 수행하는 도구성 에이전트
kubernetes의 worker node 역할

## Plugins

claude 구성(skill, hooks, Agents, Instruction, ... 등)을 묶은 단위라고 생각하면 된다.

[공식 제작 가이드](https://code.claude.com/docs/en/plugins)
[공식 플러그인 디렉토리](https://github.com/anthropics/claude-plugins-official)

## Harness

lint들을 설정하고 lint 내용은 지침에서 제외하고 workflow로 설정하라.
에이전트가(특히 subagent) 특정 스키마에 해당하는 결과 값을 내뱉도록 제한함으로써 검증 가능하도록 해라.

[오픈ai 하네스 엔지니어링 개요](https://openai.com/ko-KR/index/harness-engineering/)
[장기 애플리케이션 개발을 위한 하네스 설계](https://www.anthropic.com/engineering/harness-design-long-running-apps)

harness를 프로그래밍 방식으로 구축하는 관련 라이브러리
 [deepagents](https://github.com/langchain-ai/deepagents)
 [pydantic AI](https://ai.pydantic.dev/)
[claude sdk 사용](https://platform.claude.com/docs/en/agent-sdk/overview)

관련 연구 자료
[AutoHarness](https://arxiv.org/abs/2603.03329)

## 재귀적 자기 개선 루프

시스템은 지속적으로 향상되어. 재귀적인 복리 효과를 일으켜야한다.
이를 위해서는 harness, 측정이 매우 중요하다.
스스로 세션을 기록하고 하네스를 기반하여 결과를 측정하며 측정을 바탕으로 하네스를 개선하는 loop를 돌게끔 해라.
이때 피드백이 매우 중요한데, 피드백은 비동기적으로 받게끔(db, file, message 등에 기록) 해서 에이전트의 자기 개선 루프의 걸림돌이 되지 않도록 하여라.

[클로드 코드와 함께한 건축 과정](https://shawnos.ai/blog/6-weeks-of-building-with-claude-code)
[스스로 발전하는 에이전트 만들기](https://medium.com/@nomannayeem/lets-build-a-self-improving-ai-agent-that-learns-from-your-feedback-722d2ce9c2d9)
[클로드의 스킬 레벨을 10배로 올리는 방법 (카르파티의 자동 연구 방법을 활용)](https://x.com/itsolelehmann/status/2033919415771713715)

관련 라이브러리
[hindsight](https://github.com/vectorize-io/hindsight) : 메모리적 재귀 개선

관련 글
[MiniMax M2.7: 자기 진화의 초기 흔적](https://x.com/MiniMax_AI/status/2034335605145182659)

관련 연구 자료
[Efficient Lifelong Memory for LLM Agents](https://arxiv.org/html/2601.02553v1)
[Lifelong Learning of Large Language Model based Agents](https://arxiv.org/html/2501.07278v1)
[A Survey on the Memory Mechanism of Large Language Model-based Agents](https://dl.acm.org/doi/10.1145/3748302)
[Strategic Base Representation Learning via Feature Augmentations for Few-Shot Class Incremental Learning](https://arxiv.org/pdf/2501.09361)


