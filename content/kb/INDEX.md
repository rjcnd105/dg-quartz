---
publish: true
created: 2026-04-07T07:55:00Z
modified: 2026-05-26T07:40:22Z
tags:
  - kb
  - index
---

# KB Index

kb/ 페이지의 카탈로그. frontmatter 기반으로 재생성 가능한 캐시. `/kb rebuild-index`로 복구.

## Nix / Container

- [[Dendritic Pattern]] — NixOS 설정을 flake-parts와 auto-import 기반으로 구성하는 패턴
- [[Docker Compose 대안 비교]] — NixOS에서 Docker Compose를 대체하는 도구들의 비교. 각각의 트레이드오프.
- [[Nix flake 패키지 빌드]] — Nix flake으로 소프트웨어 패키지를 빌드하는 패턴. 언어별 빌더(`buildGoModule`, `buildNpmPackage` 등)를 사용하여 결정론적 빌드를 달성.
- [[NixOS 모듈 공유 패턴]] — 여러 NixOS 호스트가 공통 모듈을 공유하면서 호스트별 차이만 분리하는 구성 패턴.
- [[결정론적 빌드]] — 같은 입력이면 같은 출력을 보장하는 빌드 방식. Nix의 핵심 가치이자 Docker 빌드가 실패하는 지점.
- [[Nix 기반 Docker 이미지 빌드]] — Nix로 Docker 이미지를 빌드하면 결정론적이고 최소한의 레이어를 가진 이미지를 얻는다. Docker 빌드의 비결정성 문제를 해결하는 접근법.
- [[NixOS GitOps with Comin]] — Comin은 NixOS용 GitOps 에이전트. 각 노드에서 git repo를 폴링하고 구성을 자동 적용하여 `nixos-rebuild switch` 수동 실행을 불필요하게 만든다.
- [[Quadlet]] — Podman의 기능으로, 컨테이너를 systemd 서비스로 정의하여 개별 제어, 정확한 메트릭, 독립적 재시작을 가능하게 한다.
- [[quadlet-nix]] — Nix 표현식을 Quadlet 파일로 변환하는 flake. NixOS에서 컨테이너를 선언적으로 정의할 때 사용.

## Elixir / Phoenix

- [[Ecto Embedded Schema]] — 데이터베이스 테이블에 연결되지 않은 Ecto 스키마
- [[Elixir Struct]] — Elixir의 struct는 추가 기능이 있는 named map이다. `defstruct` 매크로로 정의하며, 일반 map보다 엄격하고 강력한 데이터 구조를 제공한다.
- [[LiveSvelte]] — LiveView에서 Svelte 컴포넌트를 렌더링하는 라이브러리. stateful 백엔드 프로세스와 stateful 프런트엔드 컴포넌트가 협업하는 패러다임을 제공한다.
- [[LiveView JS Commands]] — LiveView의 JS Commands(`Phoenix.LiveView.JS`)를 사용하여 서버에서 클라이언트 측 JavaScript를 트리거하는 패턴
- [[LiveView 아키텍처]] — Phoenix LiveView는 stateful 서버 프로세스가 페이지를 렌더링하고 DOM을 점진적으로 업데이트하는 웹 애플리케이션 패러다임이다
- [[typed_struct와 domo]] — Elixir struct의 boilerplate를 줄이기 위한 패키지들. 유용하지만 유지보수와 컴파일 성능에 주의가 필요하다.
- [[Ecto 커스텀 스키마 모듈]] — `Ecto.Schema`를 래핑하는 프로젝트 전용 스키마 모듈. UUID, 마이크로초 타임스탬프 등 반복 설정을 중앙화.
- [[Elixir 개발 도구]] — Phoenix/Elixir 프로젝트에서 기본으로 추가해야 할 개발 도구들.
- [[Phoenix 프로젝트 초기 설정]] — `mix phx.new`의 기본값을 실무에 맞게 바꾸는 설정들. UUID, 마이크로초 타임스탬프, 커스텀 스키마 모듈, 필수 의존성.

## CSS

- [[CSS Scroll-Driven Animations]] — CSS Scroll-Driven Animations는 keyframe animation의 progress를 시간(duration)이 아니라 scroll position이나 element visibility에 연결하는 CSS 기능이다
- [[CSS Masked Glow Border]] — CSS masked glow border는 `background-image`를 여러 mask layer로 잘라내고, pointer 위치에 따라 `conic-gradient` 시작 각도를 갱신해서 카드 테두리 주변의 glow가 포인터를 따라오는 것처럼 보이게 하는 패턴이다 (출처: Post by @jh3yy on X).
- [[CSS Style Scoping]] — CSS style scoping은 component 내부 class name이 global stylesheet에서 충돌하지 않도록 selector 적용 범위를 제한하는 문제다
- [[Fluid Responsive Design]] — 반응형 디자인을 **viewport breakpoint 중심**에서 **intrinsic·component-first 유동 시스템**으로 이동하는 접근
- [[CSS :has() 선택자]] — 특정 자식 요소를 포함하거나, 특정 요소가 뒤따르는 부모/형제 요소를 선택할 수 있는 의사 클래스다
- [[CSS Anchor Positioning]] — 한 요소(positioned element)를 다른 요소(anchor element)를 기준으로 배치하는 CSS 기능이다
- [[CSS Container Queries]] — `@container` 규칙을 사용하여 뷰포트가 아닌 개별 컨테이너 요소의 크기에 따라 스타일을 적용하는 기능이다
- [[CSS Nesting]] — CSS 선택자를 중첩하여 작성할 수 있는 네이티브 기능이다
- [[CSS Partial Keyframes]] — `@keyframes` 정의에서 `from` 또는 `to` 블록을 생략하여, 생략된 값을 요소의 현재 컨텍스트에서 상속받는 기법이다

## Frontend / JavaScript

- [[Laws of UX]] — Laws of UX는 interface design에서 자주 쓰이는 심리학·인지과학 기반 heuristic 모음이다
- [[useEffect 안티패턴]] — `useEffect`는 React가 관리하지 않는 외부 시스템과의 동기화 용도
- [[DOM 조작 최적화]] — 브라우저 DOM을 직접 조작할 때 메모리 효율과 렌더링 성능을 높이기 위한 패턴들이다
- [[Event Listener 관리 패턴]] — DOM 이벤트 리스너를 효율적으로 등록하고 정리하는 패턴들이다
- [[TanStack Router 파일 기반 라우팅]] — TanStack Router의 파일 기반 라우팅 시스템과 프로덕션에서의 실전 패턴을 다룬다
- [[WeakMap과 WeakRef]] — JavaScript에서 객체에 대한 약한 참조(weak reference)를 유지하는 메커니즘이다
- [[useSyncExternalStore]] — React 18에서 도입된 훅으로, React 외부의 데이터 소스(external store)를 구독하고 동기화하는 공식 메커니즘이다

## Database

- [[Deterministic Routing]] — Deterministic routing은 같은 key의 요청을 반복 가능한 규칙으로 같은 owner node에 보내, 분산 시스템의 stale read와 coordination 비용을 줄이는 패턴이다.
- [[ClickHouse]] — 열형(columnar) 스토리지 기반의 분석 특화 데이터베이스. 수평 확장과 계층형 스토리지를 지원하며, 대규모 실시간 분석 워크로드에 적합하다.
- [[CockroachDB]] — 전 세계 분산 SQL 데이터베이스. Google Spanner에서 영감받아 상용 하드웨어에서 글로벌 스케일의 강력한 일관성을 제공한다. Postgres wire protocol 호환.
- [[DuckDB]] — 인프로세스 임베디드 분석(OLAP) 데이터베이스. SQL을 사용하여 CSV, JSON, Parquet 등 다양한 데이터 소스를 직접 쿼리할 수 있는 "query-anything" 엔진이다.
- [[FoundationDB]] — 정렬된 key-value 스토어이자 데이터베이스를 위한 "foundation". Layer 개념으로 스토리지 엔진과 데이터 모델을 분리하며, 시뮬레이션 테스팅의 선구자다.
- [[PostgreSQL]] — "Just use Postgres"가 밈이 된 이유가 있는 범용 관계형 데이터베이스. ACID 준수, 풍부한 확장 생태계, 물리적/논리적 복제를 지원한다.
- [[SQLite]] — 애플리케이션에 직접 내장되는 local-first 데이터베이스. 단순 로컬 저장소를 넘어 분산 아키텍처와 CRDT 기반 동기화까지 확장되고 있다.
- [[TigerBeetle]] — 금융 거래 전용 단일 목적 데이터베이스. "강박적으로 정확한(obsessively correct)" 설계로, NASA의 Power of Ten Rules부터 Direct I/O까지 적용한다.
- [[결정론적 시뮬레이션 테스팅]] — 분산 시스템의 모든 비결정적 요소(네트워크, 디스크, 타이밍 등)를 시뮬레이션하여 재현 가능한 테스트를 수행하는 패러다임

## AI / LLM

- [[Perceptual Decision Feedback Loops]] — Perceptual decision feedback loops는 sensory cortex가 단순 입력 처리기가 아니라, decision variable을 downstream cortical feedback과 함께 형성할 수 있다는 관점이다.
- [[Personalized Research Automation Agents]] — Personalized research automation agents는 autonomous research pipeline이 topic만 처리하는 것이 아니라, 연구자별 resource, preference, output style, history를 장기적으로 반영해야 한다는 설계 축이다.
- [[Faithful Uncertainty]] — Faithful uncertainty는 LLM이 외부 세계의 진실을 완벽히 맞히는 능력이 아니라, 자기 내부 불확실성을 언어적 확신도와 맞추는 metacognitive 능력이다.
- [[Managed Agent Architecture]] — Managed agent architecture는 agent의 brain, hands, session을 서로 교체 가능한 interface로 분리해 long-horizon agent를 더 안정적으로 운영하는 설계다.
- [[Mixture of Experts]] — Mixture of Experts(MoE)는 model capacity와 per-token active compute를 분리하는 neural architecture다
- [[Agent Skill Representation]] — Agent skill representation은 SKILL.md 같은 자연어-heavy artifact를 agent가 검색, 선택, 검토할 수 있는 source-grounded 구조로 바꾸는 문제다
- [[Heavy Thinking]] — Heavy thinking은 여러 독립 reasoning trajectory를 만든 뒤 별도 deliberation 단계에서 비교·종합하는 test-time scaling pattern이다
- [[RL Conductor]] — RL Conductor는 worker LLM들을 직접 답변자로 쓰는 대신, 작은 LLM이 natural language workflow를 설계해 subtask, worker assignment, communication topology를 정하는 multi-agent coordination 방식이다 (출처: Learning to Orchestrate Agents in Natural Language with the Conductor).
- [[AI Organisation]] — AI organisation은 multi-agent system을 fixed team이나 message graph가 아니라 **agent workforce를 조립·관리·진화시키는 조직 레이어**로 보는 접근이다
- [[Autogenesis Protocol]] — Autogenesis Protocol (AGP)은 self-evolving agent에서 prompt, agent, tool, environment, memory를 versioned resource로 등록하고, 변경 제안-검증-commit-rollback 루프를 protocol layer로 분리하려는 제안이다 (출처: Untitled).
- [[Failure-Aware RAG]] — Failure-aware RAG는 retrieval이 실패했을 때 단순히 더 많이 검색하지 않고, 실패의 구조적 원인을 진단한 뒤 query/evidence alignment를 고치는 접근이다
- [[Native Agent Evolution]] — Native Agent Evolution은 agent가 task를 받기 전 unknown environment를 자발적으로 탐색하고, 그 결과를 reusable world knowledge로 압축하여 이후 task execution에 사용하는 self-evolution 패러다임이다 (출처: Training LLM Agents for Spontaneous, Reward-Free Self-Evolution via World Knowledge Exploration).
- [[Over-Editing]] — LLM 코딩 모델이 **필요 이상으로 코드를 고쳐 쓰는 경향**
- [[Self-Evolving Code]] — LLM 에이전트가 **전체 코드베이스**를 자율적으로 진화시키는 패러다임
- [[Agent Task Verification]] — 코딩 에이전트의 "완료했다" 자기보고를 신뢰하지 않고 독립 검증자가 사전 합의된 postcondition으로 판정하는 패턴. TEMM1E Witness가 Rust 구현으로 제시.
- [[AiScientist]] — Long-horizon ML research engineering 자율 에이전트 시스템
- [[Autoreason]] — 자기 반복 개선의 구조적 실패(prompt bias, scope creep, lack of restraint)를 A/B/AB 세 버전 경쟁 + 블라인드 Borda 투표로 해결하는 self-refinement 프레임워크
- [[Memory Transfer Learning]] — 코딩 에이전트의 self-evolving memory는 기존에 같은 도메인 내부로만 활용되었다
- [[Squeeze Evolve]] — Verifier 없이 진화적 self-evolution을 수행하는 test-time scaling 프레임워크
- [[Agent Memory Systems]] — LLM 에이전트가 과거 trajectory·결과·실패를 어떻게 저장·검색·활용하는가의 설계 공간. Long-context, RAG, guidance abstraction, 파라메트릭 내재화 네 갈래.
- [[Memory Intelligence Agent (MIA)]] — Manager-Planner-Executor 3분할 아키텍처로 Deep Research Agent의 메모리 문제를 해결하는 프레임워크
- [[Test-Time Learning]] — 추론(inference) 시점에 탐색 피드백을 사용하여 모델 파라미터를 실시간으로 업데이트하는 학습 패러다임
- [[Knowledge Graph Extraction]] — 코드, 문서, 논문, 이미지 등 이질적 소스에서 개념과 관계를 추출하여 쿼리 가능한 knowledge graph를 구축하는 기법. Graphify가 대표적 구현이다.
- [[LLM Harness]] — LLM 주변의 코드 인프라로, 정보를 저장(store), 검색(retrieve), 제시(present)하는 역할을 한다. 모델 가중치만큼 시스템 성능에 중요한 요소.
- [[LLM Wiki 패턴]] — LLM이 raw source에서 지식을 추출하여 영속적 위키를 점진적으로 구축하고 유지하는 패턴
- [[Leiden Community Detection]] — 그래프의 edge density를 기반으로 커뮤니티를 탐지하는 알고리즘. Embedding이나 벡터 DB 없이 그래프 토폴로지만으로 클러스터링한다.
- [[Scale-Dependent Verbosity]] — 큰 LLM이 과도하게 설명(over-elaborate)하면서 오류를 도입하는 현상
- [[Simple Self-Distillation]] — 모델이 자체 출력을 샘플링한 뒤 그 샘플로 SFT(Supervised Fine-Tuning)하는 기법. 외부 verifier, teacher model, RL 없이 코드 생성 성능을 크게 향상시킨다.

## Health / Science

- [[Action Symbols and Compositional Generalization]] — Action symbol은 개별 움직임이나 stroke를 낮은 수준의 근육 명령이 아니라 재조합 가능한 추상 단위로 표현하는 신경 표상이다
- [[Bacopa monnieri]] — _Bacopa monnier&#x69;_&#xB294; bacoside 계열 triterpenoid saponin을 주요 후보 성분으로 갖는 Ayurvedic botanical이며, nootropic 논의에서는 memory, attention, neuroprotection 후보로 다뤄진다.
- [[Brief Meditation EEG Dynamics]] — Brief meditation EEG dynamics는 명상을 rest-vs-meditation 평균 차이로만 보지 않고, 시작 후 몇 분 안에 brainwave pattern이 어떻게 이동하는지 추적하는 접근이다.
- [[Grapes and Skin Photoprotection]] — Grapes and skin photoprotection은 whole grape intake가 UV exposure 뒤 산화손상, skin barrier gene expression, lipid profile을 바꿀 수 있는지 보는 nutrigenomics 연구 축이다.
- [[Gut Microbiome and Insomnia Severity]] — Gut microbiome and insomnia severity 연구는 수면장애를 gut-brain axis 관점에서 보되, 불면의 원인·결과·동반 신호를 분리해야 하는 영역이다.
- [[Gut-Skin Axis in Psoriasis]] — Psoriasis gut-skin axis는 건선을 피부 국소 염증만이 아니라 장내 미생물군, 전신 염증, 면역 조절 실패가 연결된 만성 면역매개 질환으로 읽는 관점이다.
- [[Hypothalamic Menin and D-serine Aging Pathway]] — Hypothalamic Menin-D-serine pathway는 hypothalamus의 Menin 감소가 neuroinflammation, metabolic signaling, D-serine synthesis 저하를 통해 systemic aging phenotype과 cognitive decline에 관여할 수 있다는 전임상 노화 연구 축이다.
- [[IBS and IBD Microbiome Differences]] — IBS와 IBD의 microbiome 차이는 두 질환 모두 dysbiosis가 관찰될 수 있지만, 병태생리와 치료 해석이 같지 않다는 점을 분리하는 개념이다.
- [[Medication History and Gut Microbiome Confounding]] — Medication history confounding은 gut microbiome 연구에서 현재 복용 약물뿐 아니라 과거 처방 이력까지 미생물군 차이를 설명하는 숨은 변수로 다뤄야 한다는 문제다.
- [[Morganella-DEA Depression Pathway]] — Morganella-DEA depression pathway는 gut bacterium _Morganella morgani&#x69;_&#xAC00; diethanolamine(DEA)을 포함한 unusual phospholipid를 만들고, 이 물질이 TLR1/TLR2 immune signaling을 자극해 depression-linked inflammation과 연결될 수 있다는 기전 가설이다.
- [[Prefrontal Dopamine D1 and General Cognitive Ability]] — Prefrontal dopamine D1 sensitivity는 working memory, selective attention, general cognitive ability를 receptor density보다 receptor-mediated neuronal activation 관점에서 읽는 전임상 연구 축이다.
- [[Pregnenolone]] — Pregnenolone은 여러 steroid hormone과 neurosteroid의 전구체로, nootropic 커뮤니티에서는 allopregnanolone, pregnenolone sulfate 같은 downstream neurosteroid를 통해 calm focus나 stress resilience를 바꿀 수 있다는 가설로 언급된다.
- [[Resistant Starch and Butyrate Producers]] — Resistant starch and butyrate producers는 콩류와 tuber 같은 slow-fermenting substrate가 colon 깊은 부위의 butyrate-producing bacteria를 먹이고, gut barrier·inflammation·metabolic health와 연결될 수 있다는 식이-미생물군 축이다.
- [[Roseburia inulinivorans and Muscle Strength]] — _Roseburia inulinivorans_ and muscle strength 연구는 SCFA-producing gut bacterium이 muscle fiber composition, grip strength, aerobic fitness와 연결될 수 있는지 보는 gut-muscle axis 자료다.
- [[Akkermansia muciniphila]] — _Akkermansia muciniphil&#x61;_&#xB294; intestinal mucus layer와 밀접한 mucin-degrading bacterium으로, metabolic health, gut barrier, inflammation 연구에서 next-generation beneficial microbe 후보로 자주 등장한다.
- [[Autistic Traits, Uncertainty, and Affect Labeling]] — Autistic traits, intolerance of uncertainty(IU), affect labeling(AL)의 연결은 autism-related traits와 anxiety가 단일 경로가 아니라 uncertainty appraisal과 emotion labeling capacity를 통해 엮일 수 있다는 모델이다.
- [[Exercise-Induced SF1 Neurons]] — Exercise-induced SF1 neurons는 exercise training adaptation이 muscle-local 변화만이 아니라, ventromedial hypothalamus(VMH)의 steroidogenic factor-1(SF1) neuron activity와도 연결될 수 있다는 mouse 연구 축이다.
- [[Gut Microbiome Stress Reactivity]] — Gut microbiome stress reactivity는 gut microbial diversity와 SCFA-producing capacity가 acute stress 때 cortisol/subjective stress trajectory와 어떻게 연결되는지 보는 연구 축이다.
- [[Omega-3 and Exercise Adaptation]] — Omega-3 and exercise adaptation은 EPA/DHA를 단순 항염 보충제가 아니라 운동 후 염증 해소, 근육막 fluidity, blood flow, muscle protein synthesis 같은 회복·적응 과정의 후보 조절자로 보는 관점이다.
- [[Organ Intrinsic Nervous Systems]] — Organ intrinsic nervous systems는 장기 안의 peripheral neuron identity가 미리 정해진 신경 프로그램만으로 결정되는 것이 아니라, organ tissue와 extracellular matrix가 local instruction을 제공한다는 관점이다.
- [[Partially Hydrolyzed Guar Gum]] — Partially hydrolyzed guar gum(PHGG)는 guar gum을 부분 가수분해해 점도를 낮춘 soluble prebiotic fiber로, IBS/constipation tolerability와 gut microbiome shift 연구에서 자주 쓰인다.
- [[Positive Affect Treatment]] — Positive Affect Treatment(PAT)는 depression/anxiety에서 negative affect를 낮추는 것만이 아니라 low positive affect, reward sensitivity, approach behavior를 직접 표적으로 삼는 psychotherapy 접근이다.
- [[Sedentary Behavior and Movement Breaks]] — Sedentary behavior and movement breaks는 운동 부족과 별개로, 하루 중 긴 sitting bout 자체가 cardiometabolic risk와 musculoskeletal discomfort를 만든다는 관점이다.
- [[Self-Blame Network in Anxiety]] — Self-blame network in anxiety는 anxiety가 단순 worry가 아니라 guilt, shame, self-attack, self-distancing failure 같은 self-referential emotion pattern과 연결될 수 있다는 fMRI 연구 흐름이다.
- [[Senescent Cell Aptamers]] — Senescent cell aptamers는 senescent cell 표면의 결합 표지를 찾아, 노화 세포를 detection 또는 targeted delivery 대상으로 삼으려는 생명공학 접근이다.
- [[Seven-Day Fasting Proteome Response]] — Seven-day fasting proteome response는 prolonged water-only fasting에서 fuel switch보다 늦게 나타나는 systemic protein-level adaptation을 추적한 human proteomics 연구 축이다.
- [[Short-Term Diet and Biological Age Markers]] — Short-term diet and biological age markers는 식단 조성이 몇 주 단위로 cholesterol, insulin, CRP 같은 physiological biomarker profile을 바꿀 수 있는지 보는 개입 연구 축이다.
- [[Vitamin K2 and Mitochondrial Stress]] — Vitamin K2 and mitochondrial stress는 vitamin K2를 bone/vascular carboxylation만이 아니라 mitochondrial oxidative stress response와 longevity signaling 후보로 보는 전임상 연구 축이다.
- [[ADHD Mortality and Health Risk]] — ADHD 사망률과 건강 위험은 ADHD를 단순 주의력 문제가 아니라 사고, 물질 사용, 수면, 충동성, 동반질환, 의료 접근성이 누적되는 생애 위험 문제로 보는 관점이다.
- [[Almonds and Gut-Appetite Markers]] — 아몬드와 장-식욕 지표 연구는 아몬드 간식이 장내 미생물군, 대사산물, 염증 지표, 포만 호르몬을 동시에 바꿀 수 있는지 보는 식품 개입 축이다.
- [[Anger and Longevity Claims]] — Anger and longevity claims는 chronic anger, resentment, stress arousal이 건강 노화에 나쁠 수 있다는 대중 심리 narrative를 다룬다.
- [[Bedtime Procrastination and Self-Regulation]] — Bedtime procrastination은 졸리거나 자야 한다는 것을 알면서도 취침을 미루는 행동이며, self-regulation과 stress physiology가 함께 작동할 수 있다.
- [[Brain-Abdomen Hydraulic Coupling]] — 뇌-복부 수압 결합은 복부 근육 수축이 척추 정맥총을 통해 척수·뇌 압력파와 아주 작은 뇌 움직임을 만들 수 있다는 마우스 생리학 연구 축이다.
- [[Choline and Anxiety]] — Choline and anxiety 연구는 anxiety disorder에서 뇌 choline-containing compound가 낮게 관찰될 수 있다는 신호를 다룬다.
- [[Cholinergic Perceptual-Cognitive Training]] — Cholinergic perceptual-cognitive training은 acetylcholine signaling을 올리는 약물과 고부하 지각 훈련을 결합해 학습 속도를 바꿀 수 있는지 보는 연구 축이다.
- [[Emotional Trauma Symptom Clusters]] — Emotional trauma symptom clusters는 외상 경험 뒤에 나타날 수 있는 정서, 신체, 행동, 관계 반응을 묶어 보는 실용적 관찰 틀이다.
- [[Histamine Brain System]] — 뇌 histamine 시스템은 histamine을 알레르기 분자만이 아니라 인지, 감정, 수면, 보상을 조절하는 neuromodulator로 보는 연구 축이다.
- [[Holographic Principle]] — Holographic principle은 어떤 volume 안의 gravitational physics가 그 boundary에 있는 lower-dimensional information으로 기술될 수 있다는 theoretical physics 관점이다.
- [[Inner Speech and Anendophasia]] — Inner speech and anendophasia는 사람의 생각이 항상 말로 이루어진다는 가정에 의문을 제기하고, inner speech의 존재·강도·부재를 spectrum으로 보는 관점이다.
- [[Interstitium]] — Interstitium은 조직 사이의 fluid-filled space와 connective tissue network를 단절된 빈틈이 아니라 서로 연결된 fluid circulation layer로 보려는 anatomy 연구 축이다.
- [[Personalized Diet Microbiome Framework]] — Personalized diet microbiome framework는 단일 "좋은 음식"보다 개인의 반복 식품과 변동 식품이 gut microbiome을 어떻게 흔드는지 추적하려는 접근이다.
- [[Psyllium Fiber Mechanics]] — Psyllium fiber mechanics는 psyllium husk의 효과를 단순 fiber gram이 아니라 viscosity, water-holding capacity, stool water content로 설명하는 관점이다.
- [[Supplement Stack Failure Modes]] — 보충제 스택 실패 유형은 보충제 프로토콜이 실패하는 이유를 성분 효능보다 용량 계산, 목표 불일치, 누락된 진단, 생활습관 대체 관점에서 보는 분류다.
- [[Visceral Fat and Brain Aging]] — 내장지방과 뇌 노화 연구는 체중보다 복부 내장지방 노출이 장기 뇌 위축과 인지 기능에 더 직접적인 위험 지표일 수 있다는 관점이다.
- [[Vitamin B12 and Muscle Mitochondria]] — Vitamin B12와 근육 미토콘드리아 연구는 B12를 빈혈과 신경병증만이 아니라 골격근 에너지 대사와 연결해 보는 축이다.
- [[5-HT2A receptor]] — 5-HT2A receptor는 cortical pyramidal neuron과 일부 interneuron에서 psychedelic, serotonin, glutamate signaling이 만나는 GPCR target이다.
- [[Gut Microbial Tryptophan Metabolism]] — 장내 미생물의 tryptophan 대사는 식이 tryptophan이 숙주와 미생물군 사이에서 indole, kynurenine, serotonin 경로로 갈라지며 면역, 장벽, 산화환원, 미토콘드리아, 노화 관련 질병 위험을 조절하는 축이다.
- [[Gut-Derived Acetaldehyde and MASH]] — 장 유래 acetaldehyde와 MASH 연구는 식이 fructose가 장내 미생물군을 통해 ethanol 유사 독성 대사산물을 만들고, 이 대사산물이 간 섬유화를 밀 수 있다는 축이다.
- [[Gut-Eye Axis]] — 장-눈 축은 장내 미생물군, 장 장벽, 전신 면역 신호, 눈 염증을 하나의 연결 축으로 보는 관점이다.
- [[Intermittent Fasting in Older Adults]] — 고령자의 간헐적 단식은 체중, 심혈관·대사 지표, 인지·정신건강 신호를 근감소증과 허약 위험과 함께 읽어야 하는 식이 개입 영역이다.
- [[Metformin Gut Mechanism]] — Metformin gut mechanism은 metformin의 glucose-lowering effect를 liver-only model이 아니라 intestinal epithelial mitochondrial complex I inhibition으로 읽는 접근이다.
- [[Microdosing Psychedelics]] — Psychedelic microdosing은 뚜렷한 환각 효과를 피하려는 낮은 용량의 LSD, psilocybin 등 serotonin계 psychedelic 반복 사용이다.
- [[Nootropic Self-Experiment Reports]] — Nootropic self-experiment reports는 supplement나 drug-like compound를 개인이 순차적으로 시험하고 주관적 focus, mood, sleep, motivation을 기록한 낮은 신뢰도 자료다.
- [[Stem Cell Mitophagy and Senescence]] — Stem cell mitophagy and senescence 연구는 oxidative/glycative stress가 mesenchymal stem cell mitochondrial quality control을 무너뜨리고, low-dose antioxidant pretreatment가 mitophagy marker와 senescence phenotype을 일부 회복할 수 있는지 보는 영역이다.
- [[Thyroid-Serotonin Mood Axis]] — 갑상샘-serotonin 기분 축은 갑상샘 호르몬 상태가 뇌 serotonin 반응성과 정동장애 보강 치료 전략에 영향을 줄 수 있다는 관점이다.
- [[ADHD Attention State Regulation]] — ADHD의 주의력 문제는 단순한 주의력 결핍보다, 관심·각성·수면성 slow wave가 주의 배분을 흔드는 상태 조절 문제로 읽는 편이 설명력이 높다.
- [[Bacteroides fragilis Toxin]] — Bacteroides fragilis toxin(BFT)은 colon epithelial cell의 claudin-4에 먼저 결합한 뒤 E-cadherin cleavage와 inflammation/tumor axis를 유도하는 pro-carcinogenic bacterial toxin이다.
- [[Coffee and Gut-Brain Axis]] — Coffee and gut-brain axis 연구는 coffee를 caffeine source 하나가 아니라 microbiome, metabolite, inflammation, mood에 동시에 작용하는 dietary factor로 보는 접근이다.
- [[Cognitive Brain Health Span]] — 인지적 뇌 건강 수명은 노화를 피할 수 없는 하락 곡선으로만 보지 않고, 명료함, 연결감, 정서 균형 같은 다차원적 뇌 건강이 생애 동안 개선될 수 있는지 보는 관점이다.
- [[Emerging Psychiatric Drug Targets]] — Emerging psychiatric drug targets는 monoamine 중심 psychopharmacology 밖에서 ion channel, stress peptide, neuroinflammation, intracellular stress, arousal/reward system을 치료 표적으로 보는 흐름이다.
- [[GABA and Task Performance]] — Oral GABA의 task-performance claim은 stress/fatigue/confusion 감소 가능성은 흥미롭지만, 표본이 작고 blood-brain barrier 논쟁이 남아 있어 강한 nootropic 결론으로 쓰기 어렵다.
- [[Hypnagogic Mental States]] — Hypnagogic mental states는 wakefulness와 sleep을 binary로 나누기보다, memory flashes, environmental awareness, dream-like imagery, goal-directed thought가 vigilance stage와 부분적으로 독립해 나타나는 상태 공간으로 보는 접근이다.
- [[IBD Stool Host DNA Biomarkers]] — IBD 대변 숙주 DNA 생체표지자는 대변 표본 안의 사람 DNA 조각을 잡음으로 버리지 않고, 장 염증의 세포 기원 신호로 읽는 접근이다.
- [[Legumes Soy and Hypertension]] — Legume and soy intake는 potassium, magnesium, soluble fiber, soy isoflavone, short-chain fatty acid 경로를 통해 hypertension risk 감소와 연결될 수 있는 dietary pattern이다.
- [[Lithium in Mood and Suicide Risk]] — Lithium은 bipolar disorder의 장기 기분 안정화와 자살 위험 감소에서 오래된 약물이지만, 모니터링이 필요한 좁은 치료 범위를 가진다.
- [[Myelin Metabolic Signaling]] — Myelin 대사 신호는 포도당과 ketone 유래 acetyl-CoA가 oligodendrocyte 계열의 증식, 성숙, myelin 합성을 조절한다는 관점이다.
- [[PDE7 Inhibition]] — PDE7 inhibition은 cAMP breakdown을 줄여 PKA/CREB signaling, dopaminergic feedback, neuroinflammation, mitochondrial calcium handling을 조절하려는 investigational target이다.
- [[PTSD Single-Cell Neurobiology]] — PTSD 단일세포 신경생물학은 trauma 관련 정신질환을 뇌 영역 전체 평균이 아니라 세포 유형별 전사체, 후성유전체, 혈관·면역 변화로 분해하는 접근이다.
- [[Psilocybin Neuroplasticity]] — Psilocybin neuroplasticity 연구는 psychedelic acute entropy increase와 weeks-later structural/connectivity signal이 psychological insight, wellbeing, cognitive flexibility와 연결되는지 탐구한다.
- [[S1PC and Aged Garlic Extract]] — S1PC(S-1-propenyl-L-cysteine)는 숙성 마늘 추출물에 포함된 화합물로, 지방 조직의 eNAMPT 분비와 시상하부 신호 전달을 통해 노화한 근육 기능에 영향을 줄 수 있다는 연구 신호가 있다.
- [[Social Anxiety Gut-Brain Axis]] — 사회불안의 장-뇌 축은 사회불안장애의 일부 표현형이 장내 미생물군과 안쪽 전전두엽 대사를 통해 기능적으로 연결될 수 있다는 연구 가설이다.
- [[TMS Antidepressant Mechanisms]] — TMS 항우울 기전 연구는 전전두엽 피질 자극이 스트레스로 손상된 시냅스 구조와 특정 neuron 활성을 빠르게 회복할 수 있는지 탐구한다.
- [[Biomarker Interpretation Ladder]] — 생체표지자 해석 사다리는 생체표지자 연구를 읽을 때 "무엇이 실제로 증명됐는가"를 단계별로 분리하는 패턴이다
- [[Epigenetic Skin Aging]] — Epigenetic skin aging은 epidermal DNA methylation pattern을 피부의 biological age와 visible aging phenotype을 읽는 biomarker로 사용하는 접근이다
- [[Gut-Derived Metabolic Reprogramming]] — Gut-derived metabolic reprogramming은 gut microbiome 변화가 circulating metabolite, immune cell state, tissue degeneration으로 이어지는 축이다
- [[Ketamine Antidepressant Mechanisms]] — Ketamine의 빠른 항우울 효과는 단일 "NMDA antagonist" 설명만으로 충분하지 않고, 전전두엽 피질 탈억제, opioid receptor 경로, BDNF/TrkB/mGluR5 가소성이 시간대별로 나뉘는 것으로 보인다. 2026년 Weill Cornell 연구 2건을 다룬 clipping은 초기 효과와 장기 유지 기전을 분리한다 (출처: How Scientists Cracked the Ketamine Code for Depression).
- [[Melatonin]] — Melatonin은 circadian timing signal로 쓰이는 sleep supplement다
- [[NSI-189]] — NSI-189(ALTO-100, Amdiglurax)는 해마 신경생성과 가소성을 겨냥한 개발 중 저분자 약물이다
- [[Gut Microbiome and Pediatric Psychiatric Disorders]] — 소아·청소년 psychiatric disorder에서 gut microbiome 조성 차이가 관찰될 수 있다는 연구 흐름
- [[ALCAR]] — ALCAR(acetyl-L-carnitine)는 mitochondrial fatty acid transport와 acetyl group metabolism에 관여하는 carnitine derivative다
- [[Agmatine]] — Agmatine은 arginine decarboxylation으로 생기는 endogenous amine이다
- [[Alpha-GPC]] — Alpha-GPC(alpha-glycerylphosphorylcholine, choline alphoscerate)는 choline donor이자 cholinergic supplement다
- [[Alpha-lipoic acid]] — Alpha-lipoic acid(ALA, thioctic acid)는 mitochondrial enzyme cofactor이자 redox-active compound다
- [[Ashwagandha]] — Ashwagandha(Withania somnifera)는 stress, anxiety, sleep, testosterone claim으로 쓰이는 adaptogen botanical이다
- [[B-complex]] — B-complex는 thiamin, riboflavin, niacin, pantothenic acid, B6, biotin, folate, B12 등을 묶은 보충제다
- [[CoQ10]] — CoQ10(coenzyme Q10, ubiquinone/ubiquinol)은 mitochondrial electron transport chain과 antioxidant cycling에 관여한다
- [[Creatine]] — Creatine은 phosphocreatine system을 통해 ATP buffering을 보조하는 영양소다
- [[Glycine]] — Glycine은 inhibitory neurotransmitter이자 collagen, glutathione, one-carbon metabolism에 관여하는 amino acid다
- [[Huperzine A]] — Huperzine A는 Huperzia serrata에서 유래한 reversible acetylcholinesterase inhibitor다
- [[L-citrulline malate]] — L-citrulline malate는 L-citrulline과 malate를 결합한 운동 보충제다
- [[L-tyrosine]] — L-tyrosine은 dopamine과 norepinephrine 합성의 amino acid precursor다
- [[Lion's Mane]] — Lion's Mane(Hericium erinaceus)는 hericenones/erinacines, polysaccharides 등으로 NGF/BDNF, mood, cognition claim이 붙은 edible mushroom supplement다
- [[Magnesium]] — Magnesium은 신경근 흥분성, 에너지 대사, 혈압, 수면과 연관되는 필수 미네랄이다
- [[NMN and NAD+ Precursors]] — NMN, NR, NADH 같은 NAD+ precursor/booster는 cellular redox와 sirtuin/PARP/CD38 biology를 겨냥하는 longevity supplement다
- [[Phosphatidylserine]] — Phosphatidylserine(PS)는 neuronal membrane에 많은 phospholipid다
- [[Resveratrol]] — Resveratrol은 grape skin, berries, peanuts 등에 있는 polyphenol이다. SIRT1/longevity narrative로 유명하지만, 사람 clinical endpoint는 mixed이고 bioavailability 문제가 크다.
- [[Rhodiola rosea]] — Rhodiola rosea는 salidroside와 rosavins를 marker로 삼는 adaptogen botanical이다
- [[Saffron]] — Saffron(Crocus sativus) extract는 crocin, crocetin, safranal 등을 포함하는 botanical supplement다
- [[Taurine]] — Taurine은 sulfur-containing amino acid-like compound로 brain, retina, heart, muscle에 풍부하다
- [[Vitamin C]] — Vitamin C(ascorbic acid)는 collagen synthesis, antioxidant recycling, immune function에 필요한 water-soluble vitamin이다
- [[Vitamin D3 and K2]] — Vitamin D3는 calcium/phosphate homeostasis와 면역·근골격 기능에 관여하고, vitamin K2는 vitamin K-dependent protein carboxylation에 관여한다
- [[Zinc]] — Zinc는 면역, 상처 회복, taste/smell, testosterone, neurotransmission에 관여하는 필수 미네랄이다
- [[CBT-I]] — CBT-I(Cognitive Behavioral Therapy for Insomnia, 불면 인지행동치료)는 만성 불면에서 약물이나 보충제보다 먼저 권고되는 구조화된 비약물 치료다
- [[Green Tea Beverages]] — 녹차 음료는 카페인, EGCG 같은 카테킨, L-theanine을 식품 형태로 제공한다
- [[ADHD Medication and Supplement Stacking]] — ADHD 약물 위에 보충제를 쌓을 때 핵심 위험은 단일 성분보다 catecholamine 부하, serotonin계 부하, choline계 부하, CYP 상호작용, 수면 방해, 혈압·심박 변화가 누적되는 것이다.
- [[Alpha7 nicotinic acetylcholine receptor]] — Alpha7 nicotinic acetylcholine receptor(α7 nAChR)는 acetylcholine과 choline에 반응하는 ligand-gated ion channel이다
- [[Astaxanthin]] — Astaxanthin은 미세조류와 해산물에 있는 붉은 carotenoid다
- [[EGCG]] — EGCG(epigallocatechin gallate)는 녹차 catechin 중 가장 많이 연구되는 polyphenol이다
- [[Matcha]] — Matcha는 잎 전체를 분말로 섭취하는 녹차 형태다
- [[Tropisetron]] — Tropisetron은 5-HT3 receptor antagonist로 쓰이는 antiemetic 계열 약물이면서, Alpha7 nicotinic acetylcholine receptor partial agonist로도 작용한다
- [[Caffeine and Sleep Restriction]] — Lin et al. (2024)의 이중눈가림 무작위 PET-MRI 연구에 따르면, 5일의 만성 수면 제한 동안 반복적인 카페인 섭취는 수면 제한만 있을 때의 회백질 증가와 반대 방향인 회백질 감소를 동반했다 (출처: Repeated caffeine intake suppresses cerebral grey matter responses to chronic sleep restriction in an A1 adenosine receptor-dependent manner a double-blind randomized controlled study with PET-MRI).
- [[Carbohydrate Preference and Energy Expenditure]] — 단일 mouse study에 따르면, carbohydrate-rich staple food 선호는 총 calorie 섭취 증가 없이도 energy expenditure 저하와 간 지질 대사 변화로 fat mass 증가를 동반할 수 있다 (출처: Bread Might Be Making You Gain Weight Even Without Eating More Calories).
- [[N-Acetyl Cysteine]] — **N-Acetyl Cysteine (NAC)**
- [[Omega-3와 정신건강]] — Omega-3 다가불포화지방산(ALA, EPA, DHA)이 **전전두엽(PFC) 구조·기능 유지**와 염증 조절에 관여하고, Trans Fats가 이 경로를 역방향으로 교란할 수 있다는 단일 Reddit 종합 post의 주장과 관련 임상 근거를 함께 정리한 페이지. ADHD·양극성장애·불안·우울·자폐와의 연결은 질환별로 근거 강도가 다르다 (출처: The relationship between Omega 3s, fried foods and mental healthadhd.).
- [[Salicin]] — White willow bark 추출물의 주요 salicylate 계열 화합물
- [[Acetaminophen vs Ibuprofen]] — 대부분 상황에서 **acetaminophen (Tylenol/Panadol)이 ibuprofen (Advil/Nurofen)보다 안전**
- [[Bromantane]] — 러시아에서 1980년대 말 우주인·군인용 actoprotector로 개발된 adamantane 유도체
- [[Gut Microbiome Social Transfer]] — 밀접 사회 접촉이 **공유 환경과 독립적으로** 장내 미생물 전이를 유도한다
- [[L-theanine]] — 녹차의 아미노산
- [[BDNF]] — 뇌유래 신경영양인자(Brain-Derived Neurotrophic Factor). 신경 세포의 생존, 시냅스 연결, 학습·장기 기억에 필수적인 성장인자 단백질.
- [[출산 자세의 역사]] — 수천 년간 전 세계 여성은 쪼그리기, 무릎 꿇기 등 **직립 자세**로 출산했다. 누워서 출산하는 관행은 300~400년 전 시작된 비교적 최근 현상.

## Glossary

- [[Heart Rate Variability]] — HRV(Heart Rate Variability)는 연속된 심장 박동 사이 간격이 얼마나 유연하게 변하는지를 나타내는 marker다.
- [[Aryl Hydrocarbon Receptor]] — Aryl hydrocarbon receptor(AhR)는 환경·식이·microbial small molecule에 반응하는 ligand-activated transcription factor다.
- [[Kynurenine Pathway]] — Kynurenine pathway는 tryptophan이 IDO 또는 TDO를 거쳐 kynurenine 계열 metabolite로 분해되는 대사 경로다.
- [[Mitophagy]] — Mitophagy는 손상되었거나 필요 없어진 mitochondria를 autophagy machinery로 선택적으로 제거하는 mitochondrial quality-control 과정이다.
- [[DNA methylation]] — DNA methylation은 DNA 염기, 특히 CpG cytosine에 methyl group이 붙는 epigenetic modification이다
- [[Epigenetic Clock]] — Epigenetic clock은 DNA methylation pattern 같은 epigenetic marker를 사용해 tissue나 organism의 age-related state를 추정하는 statistical model이다
- [[Psychomotor Vigilance Test]] — Psychomotor Vigilance Test(PVT)는 sustained attention과 reaction time lapse를 측정하는 reaction-time task다
- [[Retinal Pigment Epithelium]] — Retinal pigment epithelium(RPE)은 photoreceptor와 choroid 사이에 있는 polarised epithelial cell layer다
- [[TrkB]] — TrkB(tropomyosin receptor kinase B, NTRK2)는 BDNF가 결합하는 receptor tyrosine kinase 계열 수용체다
- [[mGluR5]] — mGluR5(metabotropic glutamate receptor 5, GRM5)는 glutamate에 반응하는 group I G protein-coupled receptor다
- [[DAG]] — DAG(Directed Acyclic Graph)는 방향이 있는 edge를 가진 graph 중 cycle이 없는 구조다. 어떤 node에서 edge 방향을 따라 이동해 다시 같은 node로 돌아올 수 없다.
- [[Dysbiosis]] — Dysbiosis는 gut microbiome 같은 미생물 군집의 조성, 다양성, 안정성, 대사 기능이 host context에 비해 불리하게 바뀐 상태를 가리키는 넓은 용어다.
- [[Finite State Machine]] — Finite State Machine(FSM)은 시스템이 미리 정의된 상태 중 하나에 있고, event나 condition에 따라 허용된 transition만 수행하는 모델이다.
- [[PYY]] — PYY(peptide YY)는 주로 ileum/colon의 enteroendocrine L cell에서 분비되는 gut satiety hormone이다
- [[5-HT3 receptor]] — 5-HT3 receptor는 serotonin receptor 중 예외적으로 **ligand-gated ion channel**인 수용체다
- [[AMPK]] — AMPK(AMP-activated protein kinase)는 세포의 energy sensor 역할을 하는 kinase다
- [[Nrf2]] — Nrf2(nuclear factor erythroid 2-related factor 2)는 세포의 antioxidant response를 조절하는 전사인자다
- [[SIRT1]] — SIRT1은 NAD+-dependent deacetylase로, energy status와 gene regulation을 연결하는 stress response 단백질이다
- [[Adenosine Receptors]] — Adenosine receptor는 adenosine에 반응하는 G protein-coupled receptor 계열이다. Sleep pressure, neural inhibition, vascular tone, caffeine response와 관련된다.
- [[Affordances]] — James J. Gibson의 ecological psychology 용어(1979). **환경이 유기체에게 제공하는 행동 가능성**. 객체의 물리 속성 목록이 아니라 "이 유기체의 몸으로 무엇을 할 수 있나"의 관계적 속성.
- [[CREB]] — **cAMP Response Element-Binding protein**
- [[Dynorphin]] — 내인성 opioid 펩타이드 중 **kappa-opioid receptor (KOR) 선택적 리간드**. Prodynorphin 유전자에서 전구체가 잘려 생성된다.
- [[Phenomenology]] — **현상학**. 의식 경험의 구조를 1인칭 관점에서 기술·분석하는 철학 전통. Edmund Husserl이 20세기 초 정식화, Heidegger·Merleau-Ponty·Sartre 등이 확장.
- [[Trans Fats]] — **트랜스지방산**
- [[Actoprotector]] — 극한 조건(피로, 저산소, 고열, 감염 등)에서 **심신 수행을 증강**하되 고전 정신자극제(amphetamine 등)의 **소진 효과 없이** 달성하는 약물 분류
- [[NSAID]] — **Non-Steroidal Anti-Inflammatory Drug** (비스테로이드성 항염증제)
- [[File-as-Bus]] — Multi-agent coordination 프로토콜. 대화·메시지가 아니라 **파일 시스템 자체가 coordination bus**. agent 간 handoff는 파일 쓰기·읽기로 이루어짐.
- [[GRPO]] — Group Relative Policy Optimization. 한 샘플에 대해 여러 rollout을 그룹으로 생성하고, 그룹 내 상대 보상으로 advantage를 계산하여 정책을 최적화하는 PPO 변형.
- [[ReAct]] — Reasoning + Acting. LLM이 thought → action → observation 사이클을 반복하여 외부 도구와 상호작용하는 에이전트 패러다임.
- [[DocumentFragment]] — DOM 노드를 임시로 담아두는 경량 컨테이너. 실제 DOM 트리에 속하지 않아서 reflow/repaint 없이 여러 요소를 한 번에 준비할 수 있다.
- [[Ecto]] — Elixir 생태계의 데이터베이스 래퍼이자 쿼리 생성기. Ruby의 ActiveRecord나 Python의 SQLAlchemy와 비슷한 역할이지만, 설계 철학이 다르다.
- [[LiveVue]] — LiveView에서 Vue.js 컴포넌트를 렌더링하는 라이브러리. LiveSvelte의 Vue.js 버전으로, LiveSvelte 포크에서 시작해 독립 진화했다.
- [[AST]] — Abstract Syntax Tree. 소스 코드의 구조를 트리 형태로 표현한 것이다. 코드의 문법적 구조만 남기고 괄호, 세미콜론 같은 구문적 장식은 제거한다.
- [[CRDT]] — Conflict-free Replicated Data Type. 분산 시스템에서 여러 노드가 독립적으로 데이터를 수정해도 나중에 자동으로 일관된 상태로 병합되는 자료구조다.
- [[Event Bubbling]] — DOM 이벤트가 발생한 요소에서 시작하여 부모 요소를 거쳐 `document`까지 위로 전파되는 방식이다. 대부분의 DOM 이벤트가 기본적으로 버블링된다.
- [[Garbage Collection]] — 프로그램이 더 이상 사용하지 않는 메모리를 런타임이 자동으로 회수하는 메커니즘이다
- [[MVCC]] — Multi-Version Concurrency Control. 데이터베이스에서 여러 트랜잭션이 동시에 실행될 때 lock 없이 일관성을 유지하는 동시성 제어 기법이다.
- [[OLAP과 OLTP]] — 데이터베이스 워크로드를 분류하는 두 가지 기본 축이다. 각 워크로드의 특성이 달라서 서로 다른 데이터베이스 설계가 필요하다.
- [[Raft Consensus]] — 분산 시스템에서 여러 노드가 동일한 상태에 합의(consensus)하기 위한 알고리즘이다
- [[SFT]] — Supervised Fine-Tuning. 사전훈련(pre-training)된 LLM을 레이블이 있는 데이터셋으로 추가 학습시켜 특정 작업이나 출력 형식에 맞추는 과정이다.

## 기타

- [[Cognitive Ability and Probability Forecasting]] — Cognitive ability and probability forecasting는 사람이 uncertain future event의 확률을 얼마나 calibrated하게 예측하는가와 general cognitive ability가 연결되는 문제다
- [[Embodied Cognition]] — 인지를 **머릿속 정보 처리**가 아니라 **몸을 가진 존재의 세계 참여 과정**으로 보는 프레임워크

## Health

- 총 페이지: 234
- 단일 출처 페이지: 168/234 (출처 없는 페이지 36 별도)
- 미해결 논쟁: 0
- 최신 동향 만료: 0 (6개월 기준)
- 고아 페이지: 0 (glossary 제외)
- 마지막 rebuild-index: 2026-05-26
