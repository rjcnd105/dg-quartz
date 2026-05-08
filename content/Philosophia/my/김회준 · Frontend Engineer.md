---
publish: true
created: 2024-02-03T21:41:12Z
modified: 2026-05-07T06:18:43Z
tags:
  - 이력서
  - react
  - typescript
  - nextjs
  - elixir
  - ash
  - nix
  - DDD
  - feature-sliced
  - llm-ops
---

<div style="height:1rem;"></div>

7년 차 프론트엔드 엔지니어. React/TypeScript 실무를 중심으로 개발 팀에서 기술 선두적인 역할을 해왔으며, **선언적·스키마 기반** 설계를 프로젝트에 꾸준히 녹여왔습니다. 최근에는 같은 원칙을 개발 환경과 에이전트에도 확장하는 중이에요.

- **GitHub:** [rjcnd105](https://github.com/rjcnd105) · **Email:** rjcnd123@gmail.com · **Blog:** [블로그](https://rjcnd105.github.io/dg-quartz/)

---

## 주요 작업 요약

- 젠틀몬스터 메인 페이지 CSR → 전체 SSR 전환 및 렌더링 최적화 (LCP `2s대 → 0.2~0.4s대`).
- 젠틀몬스터 해외 법인 오픈 (미국·중국·호주·싱가포르·대만·일본) 프론트엔드 참여.
- 매쓰플랫 2 프론트엔드 모노레포 구조 설계, 코어 로직 작성
- 매쓰플랫 2 프론트엔드 프로젝트 아키텍처 담당. 5계층(DTO/Api/Controller/Service/Repository) 구조 작성, 컨벤션 정의 및 구형 태블릿 대응 성능 최적화. 수천개의 학원·학교 서비스에 사용됨.
- 두디스 \_요청 프로젝트\_에서 별도 백엔드 없이 Next.js + Prisma + tRPC로 BE 비즈니스 로직까지 작성.

---

## 개발 철학

그동안의 경험을 통해 실용주의적 프로그래밍을 지향하게 되었고, [Ash Framework의 Resource-oriented, Declarative Design](https://hexdocs.pm/ash/design-principles.html)에 깊이 공감합니다. 최근에는 이 방식이 **사람뿐 아니라 에이전트에게도 매우 효율적**이라는 점을 실감하고 있습니다.

- **암시적 지식을 명시적 도메인으로.** 암묵지를 코드·문서·타입·스키마·상태 모델로 옮겨 팀, 회사 차원의 명시적 도메인으로 만듭니다. 각 개개인의 기억에 의존하는 암묵지는 눈에 쉽게 보이지 않는 생산성 저하가 굉장히 크다고 생각합니다.
- **구조적 설계 기반의 빠른 프로덕트 이터레이션.** 초기에 기초적인 도메인·경계·데이터 레이어를 잡고, 프로덕트 개발을 우선시 합니다. 추상화는 프로젝트 규모에 맞춰 스탭을 나누고 점진적으로 확장합니다.
- **리소스-명시적 실천.** Agents harness, hooks, IaC, GitOps, FSM, Schema, Secreat 를 명시적으로 관리합니다. Nix, Mise 등으로 팀 개발 환경을 선언적으로 관리합니다.

<div style="height:0.5rem;"></div>

## 협업 성향

내향적인 편이지만 동료들과 논의하고 같이 문제를 푸는 과정을 즐기고, 좋은 협업은 상호 신뢰에서 나온다고 믿습니다. 이전 회사에서 **코드리뷰, KPT, PR 문화, 스터디 발표** 를 주도해 구축하고 개선했습니다.

<div style="height:0.5rem;"></div>

## Tech Stack

- **Core:** TypeScript, React, Next.js, Tailwind, React Query
- **Backend-lean:** Elixir, [Ash](https://ash-hq.org/), Phoenix
- **Declarative & Ops:** [Nix](https://nixos.org/)·NixOS, SOPS, [Mise](https://mise.jdx.dev/)

---

## 개인 환경

실무에서 지향해 온 **선언적·스키마 기반 원칙**을 개인 환경에도 동일하게 적용하고 있고, 여기서 검증한 패턴을 실무의 AI 워크플로우 도입에 이어가고 있습니다.

- **토큰 예산 관리.** 개인 프로젝트 전반에 `rtk`·`caveman`를 사용해 LLM 컨텍스트 페이로드를 압축 — 비용·지연 통제.
- **Context 관리.** `graphify` 를 통한 프로젝트 인덱싱
- **[compound-engineering-plugin](https://www.notion.so/hj1/compound-engineering-plugin) 기반 워크플로우.** 모든 작업의 plan·solution을 기록해, 에이전트가 프로젝트 맥락에 점진적으로 조율되도록 유지.
- 2024년 부터 mac에 nix flake기반 선언적 시스템 도입 (<https://github.com/rjcnd105/hj-dotfiles>)

### Home lab (개인 server)

- **Home mini-PC를 NixOS + Nix Flake로 완전 선언화.** **Comin**으로 Git 변경을 당겨 시스템에 자동 적용하는 GitOps 루프. (위 mac에서 쓰던 nix flake 시스템을 nix os로 적용)
- **에이전트 자가 수정 루프.** 에이전트가 NixOS flake를 수정 → Comin이 자동 반영 → 에이전트가 자기 실행 환경을 스스로 발전시키고 리팩터링할 수 있는 구조.
- **에이전트 메모리([Hindsight](https://hindsight.vectorize.io/) , homelab 상주).** 세션을 넘어 발전하는 context 메모리, 회고 루프로 누적 학습. llama.cpp 로컬 서빙(`harrier-oss` embedding, `qwen3-reranker`). workspace(Mac) 에서 api를 통해 claude로 hindsight context가 주입됩니다.

---

## 경력

> 최신순 정렬.

<div style="height:0.5rem;"></div>

### 아이아이컴바운드 (젠틀몬스터) · 2025.04 ~ 재직 중

- 단기 계약(2025.4.28–5.23) → 6개월 계약(2025.6–12) → **2026년 연장 계약**.
- [젠틀몬스터 사이트](https://www.gentlemonster.com/kr/ko) 및 Admin 운영 사이트의 **해외 법인 오픈**(미국·중국·호주·싱가포르·대만·일본), 성능 최적화, 운영 대응, 버그 수정.
- **성과**
  - 메인 페이지 CSR → 전체 **SSR 전환 및 렌더링 최적화**: LCP **2s대 → 0.2~0.4s대**.
  - 제품 리스트 렌더링 최적화, 메인·제품 리스트 CLS 최적화.
  - 사이트 전역 이슈 수정으로 전체 성능 개선, Next.js 서버 메모리 최적화.
  - Google Map / Baidu Map 스토어 표시 최적화.
  - 메인·제품 리스트·스토어·헤더 리팩터링.
- **보안·인증**
  - 인증/보안 이슈 진단 및 해결.
  - 노출된 secrets 식별·수정 및 재발 방지 경로 정리.
  - **팀 내 보안·인증 가이드 문서 작성.**
- **문서화:** 컴포넌트 렌더링 최적화 **가이드 문서 작성**.
- **국제화:** 중국(WeChat 계정) / 일본 / 호주 / 싱가포르 / 대만 법인 오픈.

<div style="height:0.5rem;"></div>

### 텔레스코프 · 2024.05 ~ 2024.11 (6개월 계약)

- **Stack:** Next.js, Tailwind, Strapi.
- 핵심 기능인 **여행 플랜**(작성/공유) 기능 개발.
- [tel-co.net](https://www.tel-co.net/)

<div style="height:0.5rem;"></div>

### 프리윌린 (2차) · 2023.08 ~ 2023.12 (5개월 계약)

- **기존 프로젝트 리뉴얼의 아키텍처/설계 메인 담당**으로 계약. 이해관계자들과 지속 커뮤니케이션하며 기존 문제를 분해·해결.
- 실무: 코어 모듈, 라이브러리, 공통 컴포넌트 작성. **학생 자기주도학습 프로젝트** 담당.
- **구조:** `core: domain base` · `service: trait base` · `ui: feature base`.
  - DDD / Hexagonal / Onion / Clean / Feature Sliced(프론트)를 프로젝트에 맞게 **부분 통합**.
- **도메인은 전부 스키마 기반으로 정의.** 인/디코딩으로 별도 어댑터 없이 Port 의존만으로 사용 가능 → 엔지니어링 복잡도·러닝커브 감소.
- **특성 기반 패턴(Rust trait/struct 차용)** 을 아키텍처 마일스톤 1에 도입. 여러 도메인에서 동일 trait의 비즈니스 로직을 특성 단위로 분리 → 공수 절감·유연성 확보.
- 서비스 레이어에 **Facade** 적용, 비즈니스 로직 간 상호 의존 완화.
- **컴포넌트:** design system의 headless 추상 컴포넌트에 style inject로 테마별 파생 컴포넌트 생성. 규모에 따라 **compound component**로 확장.
- **참고:** [Herberto Graca — DDD/Hex/Onion/Clean/CQRS 통합 글](https://herbertograca.com/2017/11/16/explicit-architecture-01-ddd-hexagonal-onion-clean-cqrs-how-i-put-it-all-together/), [Илья Азин — Feature Sliced](https://youtu.be/SnzPAr_FJ7w).

<div style="height:0.5rem;"></div>

### 두디스 · 2022.07 ~ 2023.01 (6개월 계약)

- Front-End Engineer **(1인)**. 메인 프로덕트 FE 전체 설계·개발, Prisma 기반 DB/백엔드 비즈니스 로직 작성.
- Turborepo 도입하여 모노레포 전환.
- **퇴사 사유:** 프로젝트 성공적으로 마치고 지원사업 통과. **계약 종료.**

#### Projects

- **소재 찾기** — PO 1, 기획 1, 디자이너 1, BE 1, **FE 1(본인)**.
  - **Stack:** Next.js (App Dir), TS, PostCSS, Tailwind, ts-rest, fp-ts, zod, Valtio, iron-session, Storybook, visx.
  - 크리에이터 의사결정을 돕는 AI/빅데이터 기반 대시보드.
  - 차트 라이브러리의 디자인 제약이 싫어 **SVG + visx(d3)로 직접 구현**.
  - Next.js 13 App Dir nested layout 활용. NestJS 백엔드와 **zod schema + ts-rest Contract 공유** → 백/프론트 모델 불일치 제거, typesafe RPC.
- **요청 프로젝트** — PO 1, 데이터 1, BE 로직 2인 _(본인 기여 80%)_, **FE 1(본인)**.
  - **Stack:** Next.js, TS, Prisma, tRPC, Chakra UI, Emotion, aws-sdk, Zustand, zod, fp-ts, iron-session, 반응형 PWA.
  - 크리에이터 펀딩·요청·심사 프로덕트. **별도 백엔드가 없어** Next.js + Prisma로 백엔드 로직 + tRPC RPC + zod 검증/transform 구축.
  - 도메인별 기능 분리 + **article/contents 컴포넌트 분리** → 모달/페이지 이중 사용, URI 동기화로 **SEO + UX 동시 확보**.
  - 댓글/에디터/이미지 S3 업로드, 한글 검색 + URL 유지 + 검색어 하이라이팅.
- **두디스 렌딩** — **FE 1(본인)**. Google SDK로 스프레드시트 폼 저장, Next.js SSG, gsap + Tailwind.

<div style="height:0.5rem;"></div>

### 프리윌린 (1차) · 2019.08 ~ 2022.02 (2년 7개월)

- Front-End Engineer (FE 팀 총 6명). **초기 멤버**로서 코드리뷰·회고·KPT·개발 발표회·퇴근 후 스터디·Personal Review·핵심 기능 리뷰 등 문화를 **주도적으로 구축·디벨롭**.
- 입사 당시 앱만 있던 상태 → **웹 버전 개발 → 알토스 시리즈 A 투자 → 매쓰플랫 2(웹앱으로 앱 대체)** 까지 수행.
- **퇴사 사유:** 조직이 커지며 업무가 **워터폴화**되고 주도권 파이가 줄어드는 것을 체감. 의사결정 단계가 늘어 새로운 시도가 어려워진 환경을 떠나, 주도적으로 일할 수 있는 환경을 찾아 퇴사.

#### Projects

- **Mathflat2 구축** — PO 1, 기획 1, 디자이너 2, BE 4, FE 4. **본인 기여: 아키텍처/구조 90%, 공용 컴포넌트 50%, 프로덕트 25%.**
  - **Stack:** React, TypeScript, MobX, Emotion, Storybook, React Hook Form, React Query.
  - 기존 네이티브 앱을 웹앱으로 대체. 태블릿 + 프린터 서버 사용 빈도가 높아 **네이티브 래퍼 + 웹앱** 구성.
  - 전반 아키텍처/구조/규범 수립. **DTO → Api → Controller → Service → Repository** 5계층, 내부 자료형은 DTO 단일 통로. ([내부 구조 설명 블로그 8번 항목](https://gggururu.tistory.com/68))
  - WeakMap 기반 클래스 레퍼런스로 목적별 Repository 구분 → 전역/컴포넌트/동적 상태를 단순하게 관리.
  - 공용 컴포넌트 단계적·부분적 확장 패턴으로 파생 컴포넌트 생성.
  - **구형 태블릿 대응 고강도 성능 최적화** — 번들 사이즈, 데이터/React Query 캐시, 렌더링, 레이아웃 시프트.
- **PDF Generator 운영·피처·리뉴얼** — BE 1, 기획 1, 디자이너 1, **FE 1**.
  - **Stack:** Puppeteer, React, TypeScript, Emotion, c3.
  - 학생 성적/진도 기반 종합 보고서 PDF 생성기. 유지보수 → 피처 추가/리팩터링 → 패키지 업데이트 → **보고서 리뉴얼(디자인 개편 + 레거시 전면 리팩터링)**.
- **Mathflat2 렌딩 페이지** — 퍼블리싱 외주본에 반응형·모션 추가. 기여 반응형/모션 80%, 그 외 30%. Stack: React, gsap, Tailwind.
- **Mathflat1 구축** — 기획/디자인 1, BE 2, 퍼블1·FE 2. **본인 기여 40%.**
  - **Stack:** React, styled-component, MobX.
  - 앱 버전을 웹 버전으로 확장. 수학 학원/학교 **수천 곳에서 사용**.
  - 입사 다음날 유일한 FE 사수가 퇴사. Redux+MobX 혼용 → MobX 단일화, CRA v1 eject 상태 → 최신 CRA 전환.
  - 공용 컴포넌트, 학생 채점·진도·출결·학생/선생님 관리 담당.

<div style="height:0.5rem;"></div>

### 이트라이브 · 2016.11 ~ 2018.11 (2년 1개월)

- UX팀 **Scripter**. 페이지 스크립트 로직, 사용자 인터랙션, 애니메이션 담당.
- **Stack:** gsap, jQuery, JavaScript, Swiper.
- **20+ 프로젝트**를 **프로젝트당 Scripter 1인(본인 100%)** 으로 수행.
- **퇴사 사유:** 당시 SPA 확산을 보며 FE 직무로 전환 욕구가 커짐. 한 페이지에 스크립트와 BE 로직이 얽혀 발생하는 커뮤니케이션 비용과 재사용성 문제가 FE의 컴포넌트 모델로 해결될 수 있음을 체감.
- [당시 포트폴리오](https://hoejun.s3.ap-northeast-2.amazonaws.com/portfolio/index.html)

---

## 학력

**동양미래대학교** · 컴퓨터 소프트웨어정보과 · 2011.03 ~ 2016.02 · **학점 4.04/4.5**

- **2015 삼성전자 SCSC-C 창의공학 경진대회 최우수** — 원격 조종·웹 영상 공유 라즈베리 CCTV (웹 파트 담당).
- **동양미래대 2015 스마트 SW 개발 경진대회 최우수** — 스토리맵(GPS 위치기반 SNS + 구글맵 임베디드). **팀장**. Python/Django + MariaDB ORM.

<div style="height:0.5rem;"></div>

## 자격 / 교육

- **자격:** 정보처리기사(2020), 정보기기운용기능사(2012), 그래픽스운용기능사(2012).
- **교육:** 패스트파이브 React 과정(2019), 그린컴퓨터아카데미 프론트엔드 과정(2016).

<div style="height:0.5rem;"></div>

## 장기 학습 프로젝트

- [[추상대수학]]
- [[elixir]]
- [[Rust in Action and The Rust Programming Language]]
- [[get programming with haskell]]

<div style="height:0.5rem;"></div>

## ETC

- [프리윌린 직무 인터뷰](https://www.jobplanet.co.kr/companies/325950/feeds/3409?_rs_act=landing&_rs_con=companies&_rs_element=feed)
- [5년 전 포트폴리오(아카이브)](https://hoejun.s3.ap-northeast-2.amazonaws.com/portfolio/index.html)
- 육군 만기 전역 · [Instagram](https://www.instagram.com/hj_s1229/)
- **나이 / MBTI:** 32 / INTP
