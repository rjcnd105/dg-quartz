---
publish: true
created: 2026-04-08T03:15:00Z
modified: 2026-04-08T03:15:00Z
tags:
  - kb
  - knowledge-graph
  - llm
  - ast
---

코드, 문서, 논문, 이미지 등 이질적 소스에서 개념과 관계를 추출하여 쿼리 가능한 knowledge graph를 구축하는 기법. Graphify가 대표적 구현이다.

## 핵심 내용

### Two-Pass Extraction

두 단계로 지식을 추출한다 (출처: [[safishamsigraphify AI coding assistant skill (Claude Code, Codex, OpenCode, OpenClaw). Turn any folder of code, docs, papers, or images into a queryable knowledge graph|Graphify README]]):

1. **Deterministic AST Pass**: tree-sitter로 코드에서 클래스, 함수, import, call graph, docstring을 추출. LLM 불필요.
2. **LLM Semantic Pass**: Claude 서브에이전트가 문서, 논문, 이미지를 병렬 처리하여 개념, 관계, 설계 근거를 추출.

결과는 NetworkX 그래프로 병합된다.

### Leiden Community Detection

그래프 토폴로지 기반 클러스터링으로 **embedding이 필요 없다**. Leiden 알고리즘이 edge density로 커뮤니티를 찾는다. LLM이 추출한 semantic similarity edge(`semantically_similar_to`, INFERRED 표시)가 이미 그래프에 포함되어 커뮤니티 탐지에 직접 영향을 준다. 별도의 벡터 DB나 embedding 단계가 불필요하다.

### Confidence Scoring

모든 관계에 출처 투명성을 부여한다:

| 태그 | 의미 | 신뢰도 |
|------|------|--------|
| `EXTRACTED` | 소스에서 직접 발견 | 항상 1.0 |
| `INFERRED` | 합리적 추론 | 0.0~1.0 점수 포함 |
| `AMBIGUOUS` | 검토 필요 | - |

### 특수 노드와 엣지 타입

- **God nodes**: 최고 degree 개념. 모든 것이 연결되는 허브.
- **Surprising connections**: composite score로 랭킹. 코드-논문 간 엣지가 코드-코드보다 높은 점수.
- **Semantic similarity edges**: 구조적 연결 없이 같은 문제를 푸는 두 함수, 같은 알고리즘을 설명하는 코드와 논문 간 교차 링크.
- **Hyperedges**: 3개 이상 노드를 묶는 그룹 관계. pairwise edge로 표현 불가능한 것들 — shared protocol 구현 클래스들, auth flow 함수들, 논문 섹션의 아이디어 그룹.

### Token Reduction

원본 파일을 직접 읽는 것 대비 쿼리당 **71.5배 적은 토큰** 소비. 첫 실행에서 그래프를 빌드(비용 발생)하고, 이후 쿼리는 compact graph를 읽어 절감이 누적된다. SHA256 캐시로 변경된 파일만 재처리.

## 실전 사용

Graphify는 Claude Code, Codex, OpenCode, OpenClaw에서 `/graphify .` 명령으로 실행한다. 출력물:

```
graphify-out/
├── graph.html       # interactive visualization
├── GRAPH_REPORT.md  # god nodes, surprising connections, 제안 질문
├── graph.json       # persistent graph (세션 간 유지)
└── cache/           # SHA256 캐시
```

Claude Code 설치 시 PreToolUse hook이 추가되어, Glob/Grep 호출 전에 그래프 존재 여부를 확인하고 구조 기반 탐색을 유도한다.

## 관련 링크

- [[LLM Wiki 패턴]] — LLM 기반 영속 지식 베이스 패턴. 위키 스케일링 시 그래프 기반 탐색과 결합 가능
- [[Leiden Community Detection]] — 그래프 토폴로지 기반 커뮤니티 탐지 알고리즘
