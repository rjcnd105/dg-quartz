---
publish: true
created: 2026-04-17T09:00:00Z
modified: 2026-04-17T09:00:00Z
tags:
  - kb
  - llm
  - agent
  - verification
  - reliability
---

코딩 에이전트의 "완료했다" 자기보고를 신뢰하지 않고 독립 검증자가 사전 합의된 postcondition으로 판정하는 패턴. TEMM1E Witness가 Rust 구현으로 제시.

## 핵심 내용

"No\_Skill\_8393" (Reddit, 2026-04)에 따르면 모든 coding agent(Claude Code, Codex, Aider, Cursor, Cline, Devin, Goose, Windsurf 등)는 장기 task에서 **확신 어린 거짓말**을 한다 (출처: [[No matter if you use Claude Code, Codex or AG or any coding agent they will eventually lie to you about task completion. Here's how TEMM1E's independent Witness system solved that]]).

근본 원인: **에이전트가 작업자이자 보고자**. 자기 자신이 완료 여부를 판단·선언한다. 분산 시스템에서 배운 원칙("NEVER TRUST THE PROCESS TO TELL YOU WHETHER THE PROCESS SUCCEEDED")이 LLM 등장 후 망각됨.

전형적 failure pattern:

- `// unchanged`, `// ... rest of the function`
- `pass # TODO`
- `throw new Error("Not implemented")`
- `return nil // placeholder`
- 함수 정의 후 caller wiring 누락

### Five Laws

Witness 시스템의 설계 원칙:

1. **Pre-commitment** — "done"의 정의를 에이전트 시작 전에 봉인. 사후 합리화 방지.
2. **Independent verdict** — 검증자는 clean-slate context. 에이전트의 CoT·self-report·대화 무접근. 파일만 읽고 check 실행.
3. **Immutable history** — SHA-256 hash-chained SQLite ledger, append-only SQL trigger. Mutation 물리적 불가.
4. **Loud failure** — 검증 실패 시 에이전트 최종 응답을 honest하게 **재작성**. "Partial completion. 1/3 postconditions verified."
5. **Narrative-only fail** — 검증자에게 파괴적 API 無. 메시지 재작성만 가능, 파일 수정·삭제 불가. 실패해도 작업물 안전.

### Oath / Witness / Ledger 3부

- **Oath**: 사전 합의 JSON 계약. Postcondition 목록. Spec Reviewer가 느슨한 Oath를 LLM 호출 전에 reject (wiring check 無, stub check 無, Tier 0 anchor 無 등).
- **Witness**: 3-tier 독립 검증자
  - **Tier 0**: 27개 deterministic predicate (`FileExists`, `FileContains`, `GrepCountAtLeast`, `CommandExits` 등). **~331μs/task, \$0**. Stub·fiction·unwired symbol 등 catastrophic pathology 탐지.
  - **Tier 1**: Clean-slate LLM reader. 대화 무접근. Oath와 파일만 읽고 JSON verdict.
  - **Tier 2**: **Adversarial auditor LLM**. "이 작업이 불완전하다는 가장 강한 논증"을 생성. Advisory-fail만 가능 (Tier 0 pass를 override 불가).
- **Ledger**: SHA-256 hash-chained SQLite, append-only triggers. 별도 watchdog binary가 file-based Root Anchor를 `chmod 0400`으로 보관 → cross-process tamper detection.

### Runtime Gate

에이전트 process\_message 루프의 "Finishing" 과 "Done" 사이에 gate 삽입:

1. Planner LLM이 Oath draft 생성 → Spec Reviewer가 accept/reject → Ledger 봉인.
2. 에이전트 루프 정상 실행.
3. "Done" emission 직전 `witness.verify_oath()` 실행 → Pass/Fail.
4. Pass → 한 줄 readout 추가 ("Witness: 6/6 PASS. Cost: \$0. Latency: +1ms.")
5. Fail → 최종 응답 재작성 ("Partial completion. 1/3 verified.")
6. TrustEngine이 autonomy streak 갱신. 연속 pass → autonomy 상승. 한 번 fail → streak reset.

### 실증

저자가 공개한 v5.3.0 수치:

- **1,800 red-team trajectories** (10 pathology × 3 tier × 3 언어 × 20 task)
- **Overall accuracy 90.0%**, **honest false-positive 0.0%**, **lying detection 88.9%**
- 10 pathology 중 9가지 100% 탐지. `lying_sandbag_constant` 만 Tier 0 한계(0%), Tier 2 auditor + Oath discipline으로 보완.
- **Latency 331μs/task, cost \$0** (Tier 0 deterministic).
- **73 real-LLM 세션**, 총 spend $0.34 (research budget $10 대비 3.43%). Gemini 3 Flash 60세션에서 clean run false-positive 0%. gpt-5.4에서 partial-completion 실시간 catch.

### 다른 에이전트에의 이식성

저자 주장: design이 language-agnostic. Runtime gate, 사전 계약, independent verifier, tamper-evident log는 모든 SWE-agent loop에 적용 가능. 개념 자체가 중요 — 특정 Rust 구현은 참고용.

> [!info] 톤
> 단일 출처(Reddit 자기홍보 + GitHub 코드·논문). 벤치 숫자는 저자 self-report 단계. 독립 재현·비평 축적 전까지 hedging 톤 유지.

## 관련 링크

- [[LLM Harness]] — 에이전트 주변 인프라. Witness는 harness의 verification 레이어에 해당
- [[Memory Intelligence Agent (MIA)]] — peer-review 스타일 다중 reviewer + AC 판정. Witness Tier 2 auditor와 유사 모티프
- [[Agent Memory Systems]] — 실패 trajectory를 negative paradigm으로 저장. Witness 실패 verdict도 유사 활용 가능
- [[Self-Evolving Code]] — CEC/DRAT formal gate가 Witness oath와 동일 철학. "evaluator를 속이지 못하게" 차단
- 원문: https://www.reddit.com/r/temm1e\_labs/comments/1skyjtt/
- 코드: https://github.com/temm1e-labs/temm1e
