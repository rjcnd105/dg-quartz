---
publish: true
created: 2026-04-07T07:55:00Z
modified: 2026-05-07T03:18:43Z
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

- [[ClickHouse]] — 열형(columnar) 스토리지 기반의 분석 특화 데이터베이스. 수평 확장과 계층형 스토리지를 지원하며, 대규모 실시간 분석 워크로드에 적합하다.
- [[CockroachDB]] — 전 세계 분산 SQL 데이터베이스. Google Spanner에서 영감받아 상용 하드웨어에서 글로벌 스케일의 강력한 일관성을 제공한다. Postgres wire protocol 호환.
- [[DuckDB]] — 인프로세스 임베디드 분석(OLAP) 데이터베이스. SQL을 사용하여 CSV, JSON, Parquet 등 다양한 데이터 소스를 직접 쿼리할 수 있는 "query-anything" 엔진이다.
- [[FoundationDB]] — 정렬된 key-value 스토어이자 데이터베이스를 위한 "foundation". Layer 개념으로 스토리지 엔진과 데이터 모델을 분리하며, 시뮬레이션 테스팅의 선구자다.
- [[PostgreSQL]] — "Just use Postgres"가 밈이 된 이유가 있는 범용 관계형 데이터베이스. ACID 준수, 풍부한 확장 생태계, 물리적/논리적 복제를 지원한다.
- [[SQLite]] — 애플리케이션에 직접 내장되는 local-first 데이터베이스. 단순 로컬 저장소를 넘어 분산 아키텍처와 CRDT 기반 동기화까지 확장되고 있다.
- [[TigerBeetle]] — 금융 거래 전용 단일 목적 데이터베이스. "강박적으로 정확한(obsessively correct)" 설계로, NASA의 Power of Ten Rules부터 Direct I/O까지 적용한다.
- [[결정론적 시뮬레이션 테스팅]] — 분산 시스템의 모든 비결정적 요소(네트워크, 디스크, 타이밍 등)를 시뮬레이션하여 재현 가능한 테스트를 수행하는 패러다임

## AI / LLM

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

- [[Epigenetic Skin Aging]] — Epigenetic skin aging은 epidermal DNA methylation pattern을 피부의 biological age와 visible aging phenotype을 읽는 biomarker로 사용하는 접근이다
- [[Gut-Derived Metabolic Reprogramming]] — Gut-derived metabolic reprogramming은 gut microbiome 변화가 circulating metabolite, immune cell state, tissue degeneration으로 이어지는 축이다
- [[Ketamine Antidepressant Mechanisms]] — Ketamine의 rapid antidepressant effect는 단일 "NMDA antagonist" 설명만으로 충분하지 않고, prefrontal cortex disinhibition, opioid receptor 경로, BDNF/TrkB/mGluR5 plasticity가 시간대별로 나뉘는 것으로 보인다. 2026년 Weill Cornell 연구 2건을 다룬 clipping은 초기 kick과 장기 유지 mechanism을 분리한다 (출처: How Scientists Cracked the Ketamine Code for Depression).
- [[Melatonin]] — Melatonin은 circadian timing signal로 쓰이는 sleep supplement다
- [[NSI-189]] — NSI-189(ALTO-100, Amdiglurax)는 hippocampal neurogenesis와 plasticity를 겨냥한 investigational small molecule이다
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
- [[Green Tea Beverages]] — Green tea beverages are food-format sources of caffeine, catechins such as EGCG, and L-theanine
- [[ADHD Medication and Supplement Stacking]] — ADHD 약물 위에 supplement를 쌓을 때 핵심 위험은 단일 성분보다 catecholamine load, serotonergic load, cholinergic load, CYP interaction, sleep disruption, BP/HR 변화가 누적되는 것이다.
- [[Alpha7 nicotinic acetylcholine receptor]] — Alpha7 nicotinic acetylcholine receptor(α7 nAChR)는 acetylcholine과 choline에 반응하는 ligand-gated ion channel이다
- [[Astaxanthin]] — Astaxanthin은 미세조류와 해산물에 있는 붉은 carotenoid다
- [[EGCG]] — EGCG(epigallocatechin gallate)는 녹차 catechin 중 가장 많이 연구되는 polyphenol이다
- [[Matcha]] — Matcha는 잎 전체를 분말로 섭취하는 녹차 형태다
- [[Tropisetron]] — Tropisetron은 5-HT3 receptor antagonist로 쓰이는 antiemetic 계열 약물이면서, Alpha7 nicotinic acetylcholine receptor partial agonist로도 작용한다
- [[Caffeine and Sleep Restriction]] — Lin et al. (2024)의 double-blind randomized PET-MRI study에 따르면, 5일 chronic sleep restriction 동안 반복 caffeine intake는 sleep restriction만 있을 때의 grey matter upregulation과 반대 방향의 grey matter reduction을 동반했다 (출처: Repeated caffeine intake suppresses cerebral grey matter responses to chronic sleep restriction in an A1 adenosine receptor-dependent manner a double-blind randomized controlled study with PET-MRI).
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

- [[DNA methylation]] — DNA methylation은 DNA 염기, 특히 cytosine 주변에 methyl group이 붙는 epigenetic modification이다
- [[Epigenetic Clock]] — Epigenetic clock은 DNA methylation pattern 같은 epigenetic marker를 사용해 tissue나 organism의 biological age를 추정하는 statistical model이다
- [[Psychomotor Vigilance Test]] — Psychomotor Vigilance Test(PVT)는 sustained attention과 reaction time lapse를 측정하는 간단한 vigilance task다
- [[Retinal Pigment Epithelium]] — Retinal pigment epithelium(RPE)은 retina 바깥쪽에 있는 epithelial cell layer다
- [[TrkB]] — TrkB(tropomyosin receptor kinase B)는 BDNF가 결합하는 receptor tyrosine kinase 계열 수용체다
- [[mGluR5]] — mGluR5(metabotropic glutamate receptor 5)는 glutamate에 반응하는 G protein-coupled receptor다
- [[DAG]] — DAG(Directed Acyclic Graph)는 방향이 있는 edge를 가진 graph 중 cycle이 없는 구조다. 어떤 node에서 edge 방향을 따라 이동해 다시 같은 node로 돌아올 수 없다.
- [[Dysbiosis]] — Dysbiosis는 gut microbiome 같은 미생물 군집의 조성이 건강한 기준에서 벗어난 상태를 가리키는 넓은 용어다.
- [[Finite State Machine]] — Finite State Machine(FSM)은 시스템이 미리 정의된 상태 중 하나에 있고, event나 condition에 따라 허용된 transition만 수행하는 모델이다.
- [[PYY]] — PYY(peptide YY)는 주로 장에서 분비되는 satiety hormone으로, 식후 포만감과 food intake regulation에 관여한다.
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

- 총 페이지: 152
- 단일 출처 페이지: 104/152 (출처 없는 페이지 32 별도)
- 미해결 논쟁: 0
- 최신 동향 만료: 0 (6개월 기준)
- 고아 페이지: 0 (glossary 제외)
- 마지막 rebuild-index: 2026-05-07
