---
publish: true
title: 김회준 · Frontend Engineer
created: 2024-02-03T21:41:12Z
modified: 2026-07-15T07:51:55Z
tags:
  - 이력서
  - frontend
  - react
  - typescript
  - nextjs
  - architecture
  - developer-experience
---

## 소개

7년 차 프론트엔드 엔지니어로서 늘 팀의 기술 선도적인 역할을 담당하였습니다. 프로젝트의 아키텍처를 설계하고, 팀 내 컨벤션을 정의하고 공통 컴포넌트 및 핵심 비즈니스 로직들을 개발하는 일을 맡아왔습니다.
제품 규모, 도메인 복잡도와 팀의 작업 방식을 기준으로 적합한 설계 원칙과 구조를 선택해 적용합니다. 제품이 커진 뒤에도 팀이 구조를 이해하고 기능을 계속 바꿀 수 있도록 도메인과 레이어의 경계를 잡는 일이 제 강점입니다.
DX를 개선해 팀 전체의 업무 효율을 높이는 데 큰 성취감을 느낍니다.

[GitHub](https://github.com/rjcnd105) · [Blog](https://rjcnd105.github.io/dg-quartz/) · [Email](mailto:rjcnd123@gmail.com)

## 기술

- **주력**: TypeScript, React, Next.js, CSS, HTML
- **라이브러리**: TanStack Query, React Hook Form, Tailwind CSS, Emotion, Storybook, tRPC, Prisma, D3.js(visx), Sentry
- **개인 개발 환경**: Nix, NixOS, Nix Flakes, Mise, SOPS, Jujutsu, TanStack Router, Elixir, Phoenix, Ash Framework, PostgreSQL

## 설계와 프로젝트 운영

- 프로젝트의 거시적 설계 원칙은 [Ash Framework의 Resource-oriented, Declarative Design](https://hexdocs.pm/ash/design-principles.html)을 지향합니다. 리소스와 가능한 행위, 제약을 코드에 명시해 사람과 AI 에이전트가 같은 구조를 읽도록 하며, 에이전트에게는 `Code is the spec` 처럼 동작합니다.
- 스키마와 명세를 단순한 타입 보조가 아니라 도메인 규칙을 소유하는 코드로 사용합니다. API 데이터, 애플리케이션 상태와 폼이 같은 용어와 제약을 공유하도록 구성합니다.
- 유저와 직접 맞닿는다는 책임이 늘 있습니다. UI·UX·Interaction 까지 고민하고 데이터를 기반하여 개선하고자 합니다.
- Hexagonal Architecture와 FSD를 비롯한 여러 설계 방법론을 정해진 형태 그대로 적용하지 않습니다. 제품의 도메인 개념을 팀의 공통 언어로 삼아 구조를 이해하고 작업 맥락을 이어가는 부담을 줄입니다. 제품 규모와 팀의 실제 업무 흐름을 계속 살피며 적용할 원칙과 경계를 조정합니다.
- 초기 구축 뒤에도 LLM Context 세팅, 패키지 업데이트, 성능 문제, 운영 이슈, 리팩터링과 문서화까지 이어서 맡습니다. 아키텍처를 한 번 정하고 끝나는 결과물이 아니라 책임감을 가지고 지속적으로 관리해야 하는 프로젝트의 상태로 봅니다.

## 업무 히스토리

- 프론트엔드 팀 내부 문화인 KPT, 회고, 팀 업무 관리, 오프라인 코드리뷰, 스터디 등을 구성하고 주도한 경험이 있습니다.
- OAuth 2.0, MFA(2단계 인증), SSO 기반의 인증을 구현했습니다. 토큰·세션 만료, 안전한 리다이렉트와 브라우저 노출 정보에 대한 프론트엔드에서의 보안적인 책임도 수행했습니다.
- 여러 국가와 법인 오픈 과정에서 국제화, locale routing과 번역 데이터 흐름을 다뤘습니다.
- Headless·Compound Component 패턴을 활용해 재사용 가능한 공용 컴포넌트를 만들고, 디자인 시스템을 개발하고 공통 스타일의 기준으로 관리했습니다.
- 페이지의 데이터 갱신 주기, SEO와 캐시 조건에 따라 SSR, ISR과 클라이언트 렌더링을 선택합니다. 인증·보안, 렌더링 최적화와 컴포넌트 설계 기준을 팀 가이드로 작성해 왔습니다.
- OpenApi spec을 기반한 type generate를 하여 사용하고, node 기반 서버의 경우 tRPC로 end to end typesafe 처리를 하였습니다.
- monorepo 기반으로 프로젝트 레이어의 책임과 경계를 명확히 하여 구성하였습니다.

## 경력 사항

경력 사항은 날짜 내림차순으로 작성되었습니다.

### 아이아이컴바운드(젠틀몬스터)

**계약기간: 2025.4.28 ~ 2025.5.23(단기) 이후 2025.6 ~ 2025.12 이후 추가 연장 계약 2026 ~**

[젠틀몬스터 사이트](https://www.gentlemonster.com/kr/ko), 젠틀몬스터 Admin 운영 사이트 해외 법인 오픈(미국, 중국, 호주, 싱가포르, 대만, 일본), 성능 최적화, 운영 대응, 버그 수정

컴포넌트 타입 별(SSR ISR CSR) 렌더링 최적화 가이드 작성, 보안 가이드 작성

**최적화**

- 메인 페이지 CSR 되던 것 전체 SSR로 변경 및 렌더링 최적화(LCP 2초대 -> 0.2~0.4초대)
- 제품리스트 CLS, 렌더링 최적화
- 사이트 전역에 영향을 미치는 이슈들 수정하여 성능 최적화
- nextjs 서버 메모리 최적화
- google map, baidu map에 표시되는 스토어 최적화

**리펙토링**
메인, 제품 리스트, 스토어, 헤더 리펙토링을 했습니다.

**국제화(법인 오픈)**
언어 및 통화 국제화, 법인별 비즈니르 로직을 개발했습니다.
중국(wechat), 일본(line), 호주, 싱가포르, 대만

#### PS Admin (Product Service Admin)

Google AI 스마트 글래스 AS를 포함한 제품 서비스 운영 시스템으로, 삼성 임직원들과 각 매장 담당자, CS 관리자가 사용합니다.

프론트엔드 설계부터 전체 구축을 90% 담당했습니다.

---

### 텔레스코프

**계약 기간: 2024.5 ~ 2024.11 (6개월 기간 계약)**

**Teck stack**
nextjs, tailwind, strapi

주요 기능인 여행 플랜 관련해서 여행 플랜 작성, 여행 플랜 공유 등의 기능을 만들었습니다.

https://www.tel-co.net/

---

### 리멤버

**기간: 2023.1 ~ 2023.2**

**퇴사 사유**

회사의 현재 방향과 제가 팀에 기여할 수 있는 것으로 기대 했던 것들이 맞지 않아 나오게 되었습니다.

---

### 프리윌린

**계약 기간: 2023.08.08 ~ 2023.12.29 (5개월)**

기존 프로젝트 리뉴얼에 대한 아키텍쳐, 프로젝트 설계 메인 담당으로 계약했습니다. 가지고 있던 문제점들을 모두와 지속적인 커뮤니케이션을 통해 해결 방법을 고안했습니다.

코딩 작업으로는 코어한 모듈, 라이브러리, 공통 컴포넌트를 작성하고 학생의 자기주도학습 프로젝트를 했습니다.

- core: domain base
- service: trait base
- ui: feature base

비즈니스 도메인을 기반으로 한 통합 Hexagonal, Onion, Clean, Feature Sliced(front단) 에 프로젝트에 맞게 partial하게 적용하고 적합한 구조로 변형했습니다.

도메인은 전부 스키마 기반으로 작성됩니다. <https://github.com/Effect-TS/schema> 인/디코딩을 통해 따로 추상화된 어댑터 레이어를 두지 않고서도 Port에만 의존적으로 사용할 수 있으며 그로 인해 엔지니어링 복잡도를 줄이고 러닝커브를 줄일 수 있습니다.

특성 기반의 패턴을 두어 아키텍쳐 마일스톤 1에서는 [Rust의 Trait](https://doc.rust-lang.org/book/ch10-02-traits.html), [Struct](https://doc.rust-lang.org/book/ch05-01-defining-structs.html)의 개념을 활용합니다. 이는 비즈니스 도메인 스키마와 별도로 어플리케이션 서비스에서 주로 활용되어 집니다. 여러 도메인에서 동일 trait에 대한 비즈니스 로직을 특성 단위로 분리함으로서 작업 공수가 크게 줄어듭니다. 하위 레이어단에서 도메인 비즈니스 로직에 의존되는게 아닌 trait에 의존되는 형태로 구성할 수 있어서 융통성 있는 구성이 가능합니다.

서비스 레이어단에서는 Facade 패턴을 사용하여 각 비즈니스 로직간의 상호 의존성을 줄였습니다.

컴포넌트는 style을 따로 inject 받으며 기본적으로 추상화된 headless component가 design system에 존재합니다. style에 대해 inject를 함으로써 각각의 프로젝트에서 테마(style set)를 적용하여 파생(derived) 컴포넌트를 사용하게 됩니다. 컴포넌트의 구성 요소 규모에 따라 headless [compound component](https://www.patterns.dev/posts/compound-pattern) 으로 작성될 수 있습니다.

[react-router의 DataApi를 활용](https://reactrouter.com/en/main/guides/deferred)하여 기존의 직렬적인 네트워크 요청을 병렬, 또는 선 fetch 후 바로 그리는 형태로 CLS를 최적화 할 수 있는 구성을 합니다. 이로 인해 비약적인 성능 개선을 할 수 있습니다.

참고한 내용들) 여러 article, framework, library, programming language principle partial DDD series, Feature Sliced, All together(DDD, Hexagonal, Onion, Clean, CQRS …)

[DDD, Hexagonal, Onion, Clean, CQRS, … How I put it all together](https://herbertograca.com/2017/11/16/explicit-architecture-01-ddd-hexagonal-onion-clean-cqrs-how-i-put-it-all-together/?utm_source=pocket_saves)
[Доклад: Feature Sliced — Архитектура Frontend-проектов / Илья Азин](https://youtu.be/SnzPAr_FJ7w)

---

### 젤리페이지

**재직 기간: 2023.03 ~ 2023.06 (3개월)**

Web Frontend 팀(4인) 테크 리드

웹 프론트엔드 프로덕트 프로젝트들 전체 설계
turborepo + pnpm 모노레포로 제작하였으며 내부의 공통 모듈, 스타일, 컴포넌트 패키지를 목적에 따라 분리

**역할**

1. 전체 프로젝트들 구조 설계하고 내부의 코어 로직 개발 및 공용 컴포넌트 개발
2. 프로덕트 전반적인 도메인에 해당하는 공통 스키마를 정의
3. 코드 스타일, git 브랜치, api 테스트, 단일 테스트, 성능 최적화, 구조, 서버 컴포넌트, 클라이언트 컴포넌트, ISR, 라우팅 등에 대한 컨벤션을 정하고 적용시켰으며 팀원들을 교육하였습니다.
4. 3개의 프로젝트를 동시에 진행하면서 각각의 프로젝트들이 일정에 맞출 수 있도록 유동적으로 투입되어서 작업했습니다.

**퇴사 사유**

입사 전부터 정해져있던 무리한 공식 일정과 여러가지 역할로 인해 주로 새벽까지 일하고 매 주말에도 일하면서 건강이 나빠져 마일스톤1에 맞춰 제작 후 퇴사했습니다.

#### Projects

---

- **JellyPage2**

  팀원: PO 1, 기획 1, 디자이너 2, DBA 1, 백엔드 3, 프론트 4(**본인 포함**), 플러터 1

  **Teck stack**
  next13 app, turborepo, tailwind, storybook, zod, zodios, react-query, valtio, effect/data

  **개요**

  다양한 디바이스(모바일, pc)에서 독서를 할 수 있는 cross platform앱 입니다.
  플러터 앱 안에 들어가는 웹앱으로 구성되어 있습니다.

  프로젝트 전체 구조, 기술스택 설계와 스키마 정의, 더불어 보안, 인증, jwt 토큰 관련 작업들을 했습니다.
  6가지가 넘는 다양한 회원 전환, 회원 통합, 회원 삭제, 가입, 회원 선택에 대한 케이스를 통합하는 로직들을 구성했습니다.
  보안성을 위해 nextjs 서버측에서 rest api를 통해 시크릿키를 통해 구글, 애플, 네이버, 카카오, 젤리 로그인을 구현했습니다.
  추가로 온보딩 프로세스에 대한 기능, api 작업들을 하였고, 여러 케이스에 대한 온보딩 시작 분기, step 분기 처리를 하였습니다.

- **JellyReading**
  팀원: PO 1, 기획 1, 디자이너 1, DBA 1, 백엔드 2, 프론트 2(**본인 포함**)

**Teck stack**
next13 app, turborepo, tailwind, storybook, zod, zodios, react-query, valtio, effect/data

**개요**

```
문해력을 향상시키기 위한 비문학, 문학에 대해서 지문별로 다양한 케이스의 학습을 할 수 있는 학원을 위한 솔루션 입니다.

**개발사항**

프로젝트 전체 구조, 기술스택 설계와 스키마 정의를 하였습니다.
구조학습 기능을 작업하였습니다.
문장, 단어와 관련된 공통 컴포넌트들을 제작했습니다.
```

- **JellyReading CMS**
  팀원: 기획 1, 백엔드 1, 프론트 1 (**본인**)

**Teck stack**
next13 app, turborepo, prosemirror, remirror, tailwind

**개발사항**
remirror와 prosemirror을 통해 지문, 문단, 문장을 구별해서 저장할 수 있는 에디터를 만들었습니다.

---

### 두디스

**계약 기간: 2022.7 ~ 2023.01 (6개월)**

Front-End Engineer로 근무 (1인)

메인 프로덕트 전체 frontend project 설계 & 개발, prisma를  사용한 데이터베이스, 백엔드 비즈니스 로직 작성

turborepo를 도입하여 monorepo프로젝트로 변환

**퇴사 사유**
프로젝트를 성공적으로 마치고 지원사업에 통과했으며 계약상의 종료입니다.

#### Projects

---

- **소재 찾기**

  팀원: PO 1명, 기획자 1명, 디자이너 1명, 백엔드 1명, **프론트엔드 1명(본인)**

  **Teck stack**
  nextjs appDir, ts, postcss, tailwind, ts-rest, fp-ts, zod, valtio, iron-session, storybook, visx

  **개요**

  대시보드에 통계와 그래프, 최신의 트랜드를 통하여 크리에이터의 의사결정을 도와주는 AI, 빅데이터 기반의 시스템입니다.

  **개발 사항**

  매번 프로덕트에 맞는 차트 라이브러리를 찾는 수고와 디자이너에게 차트의 디자인적 제한 요소를 주기 싫어 svg, visx(d3)를 공부하여 디자이너의 요구사항에 따라 그래프를 직접 그리고 있습니다.
  nextjs13의 appDir을 통한 nested layout을 활용하며 nestjs를 사용하는 백엔드 개발자와의 도메인을 맞추기 위해 공통 라이브러리를 사용하며 zod Schema, ts-rest Contrect(API Route)를 공유합니다.

  Schema를 공유함으로써 백엔드단 모델과 클라이언트단의 모델과의 불일치가 발생할 수 없으며 ts-rest를 사용함으로써 RPC 방식으로 백엔드에게 요청을 typesafe하게 함수를 호출하듯 사용할 수 있습니다.
  이로 인해 불필요한 커뮤니티 비용의 절감과 typesafe한 RPC 통신을 할 수 있습니다.

---

- **요청 프로젝트**

  팀원: PO 1명, 데이터 1명(devops, 인증, 약간의 비즈니스 로직), 백엔드 비즈니스 로직 (2인, **본인 기여도 80%**), **프론트엔드 1인(본인)**

  **Teck stack**
  nextjs, ts, prisma, trpc, chakra-ui, emotion, aws-sdk, zustand, zod, fp-ts, iron-session, 반응형 pwa, nextjs와 prisma, trpc를 이용한 대부분의 백엔드 비즈니스 로직 개발, api 설계

  **개요**

  크리에이터한테 펀딩금을 걸고 글과 이미지를 통해 컨텐츠를 요청하고 다른 사람이 펀딩한 것에 펀딩하고 크리에이터의 심사 과정을 거쳐 요청이 거절되거나 승락될 수 있는 프로젝트 입니다.

  **개발 사항**

  백엔드 개발자가 따로 없어서 nextjs의 서버에서 prisma를 사용해 백엔드 비즈니스 로직들을 작성했습니다. 그리고 trpc를 통해 nextjs 서버와 클라이언트 간에 RPC 통신을 하였으며 zod schema 스키마를 통한 벨리데이션, typesafety, transform의 효과를 챙겼습니다.

  각 기능을 도메인별로 분리를 하였으며 article(독립 기능 단위), contents(페이지 단위)의 컴포넌트 구분을 두어 각 기능이나 페이지를 독립적으로 사용할 수 있게 하였습니다.

  그로 인해 페이지를 모달로도 띄울 수 있었으며 SEO를 위해 모달로 뜰때 URI를 바꾸어주고 새로고침을 하면 해당 URI에 해당하는 페이지를 보여주게끔 함으로써 사용자 편의성과 SEO를 둘 다 잡았습니다.

  댓글 작성 및 에디터를 통한 글 작성, 이미지 aws에 업로드, 한글 검색 및 검색 결과 URL을 통한 유지. 검색 결과에 매칭되는 글들 하이라이팅 등을 작업했습니다

---

- **두디스 렌딩**

  팀원: **프론트엔드 1명(본인)**

  **Teck stack**
  google sdk사용하여 spreadsheet에 폼 데이터 저장
  nextjs SSG로 제작.
  gsap를 이용한 애니메이션, tailwind를 이용한 스타일링

---

### 프리윌린

**재직 기간: 2019. 8 ~ 2022. 2 (2년 7개월)**

Front-End Engineer로 근무 (총 프론트엔드 팀 6명)

초기 멤버로서 여러 문화(코드리뷰, 회고, KPT, 개발 발표회, 퇴근 후 스터디, Personal Review, 핵심 기능 개발 완료 후 리뷰 등)을 주도하에 만들고 지속적인 디벨롭을 하였습니다.

초기 앱만 있을때 입사해서 웹 버전을 개발하고 알토스 시리즈A 투자를 받았으며 현재의 매쓰플랫2(웹앱으로 앱 대체)까지 개발 완료 했습니다.

**퇴사 사유**
조직이 커지면서 업무 방식이 점점 워터폴화 되고 주도적으로 일할 수 있는 파이가 점점 줄어드는 것을 느꼈습니다.
또 의사 결정 단계가 많아지고 과정이 복잡해져서 빠르게 새로운 시도를 해보기 어려운 환경이 되었습니다.
그래서 **새로운 시도를 할 수 있는 문화, 주도적으로 일할 수 있는 환경**에서 일하고 싶은 갈증이 느껴져서 퇴사하게 되었습니다.

#### Projects

---

- **Mathflat2 구축**

  팀원: PO 1명, 기획자 1명, 디자이너 2명, 백엔드 4명, 프론트 4명 - **본인 기여: 아키텍쳐∙구조 90%, 공용 컴포넌트 50%, 프로덕트 25%**

  **Tech stack**
  react, typescript, mobx, emotion, storybook, react-hook-form, react-query

  **개요**

  기존의 네이티브 앱을 대체하면서 기능들과 사용성을 개선하기 위해 Mathflat2를 새롭게 만드는 결정이 되었습니다.

  태블릿을 통해 프린터 서버를 통해 보고서를 프린터로 바로 뽑는 케이스가 많았으므로 네이티브 앱으로 감싼 웹앱으로 했습니다.

  **개발 사항**

  전반적인 프로젝트 아키텍쳐, 구조설계와 규범을 정했습니다.

  레이어단을 DTO, Api, Controller, Service, Repository를 나누고 그 내부의 모든 자료형들은 DTO를 넘기는 방식으로 하였습니다. (백엔드단과 단어 의미가 햇갈릴 수 있습니다. **[자세한 내용은 여기 8번에 적어놓았습니다.](https://gggururu.tistory.com/68)**)

  WeekMap을 활용한 클래스의 레퍼런스 값을 통해 스토어를 활용해 각 목적에 맞는 Repository를 구분해 전역, 컴포넌트, 동적 상태 관리를 쉽고 효율적으로 할 수 있게 하였습니다.

  공용 컴포넌트의 비중을 조금 높게 작업을 하였습니다. 그 과정에서 코어한 컴포넌트의 확장성, 유연성에 대한 깊은 고민을 하여 단계적, 부분적 적용하여 파생되는 컴포넌트를 생성할 수 있는 패턴을 적용하였습니다. 그 외 수업, 숙제, 진도, 채점, 출결 관리, 선생님의 권한 관리, 학생 관리, 앱 설정 등을 작업했습니다.

  구형 태블릿에서 발생하는 웹앱의 성능 이슈를 해결하기 위해 **강도 높은 성능 최적화**를 했습니다. (번들 사이즈 최적화, 데이터 캐싱, react query 캐시, 컴포넌트 렌더링 최적화, 레이아웃 시프트 최적화 등)

---

- **PDF Generator 운영, 피쳐, 리뉴얼**

  팀원: 백엔드 1명, 기획자 1명, 디자이너 1명, **프론트엔드 1명**

  **Tech stack**
  puppeteer, react, typescript, emotion, c3

  **개요**

  매쓰플랫으로부터 학생의 교재, 학습지 진도와 성적을 기반으로 종합 보고서를 만드는 puppeteer를 이용한 보고서 pdf 제네레이터입니다.

  **개발 사항**

  처음에 유지 보수를 하면서 자잘한 차트와 내용 수정을 했습니다.

  점차 새로운 피쳐들이 추가 및 리펙토링을 하였으며 오래된 패키지들을 업데이트 하였습니다.

  그 후 보고서 리뉴얼을 하며 디자인을 개편하였고 기존의 레거시를 전부 리펙토링하여 컴포넌트를 분리하고 스타일을 모듈화 해서 유지보수 하기 쉬운 구조로 바꾸었습니다.

---

- **Mathflat2 렌딩 페이지**

  퍼블리싱 외주 작업 된 것에 반응형과 모션을 추가, 모션 애니메이션을 작업하고 그 외 수정, 유지 보수 작업을 하였습니다.

  **기여**

  반응형•모션 80%, 그 외 30%

  **Tech stack**

  react, gsap, tailwind

---

- **Mathflat1 구축**

  팀원: 기획•디자이너 1명, 백엔드 2명, 퍼블1∙프론트엔드 2명 - **본인 기여 40%**

  **Tech stack**
  react, styled-component, mobx

  **개요**

  Mathflat이라는 수학 선생님을 위한 웹 종합 솔루션을 제작하였습니다.

  기존에 앱으로 있던 것을 웹버전으로 만들면서 웹 환경에 적합하게 앱과 다르게 디벨롭되었습니다.

  학생, 반, 선생님 관리, 출결 관리, 문제 관리, 학습지 만들기, 교재 만들기, 숙재내기 (학생 앱으로 숙제 나감) 학생의 진도와 점수 채점, 관리. 학생의 성적에 대한 보고서를 출력할 수 있는 프로덕트 입니다.

  수천개의 수학 학원 및 학교에 사용되었습니다.

  **개발 사항**

  입사하자마자 프론트엔드에 단 1명 있는 사수가 바로 다음날 퇴사를 해서 고생을 했습니다. 기존에 redux와 mobx를 섞어 사용하고 있어 redux를 mobx로 변환하였으며 create-react-app v1을 eject해서 사용 중이라 최신의 cra로 바꾸는데 고생했습니다..

  스크립터로 활동하다 리엑트를 사용해 회사에서 사용한 처음 프로젝트라 우여곡절이 많았지만 이 프로젝트로 인해 리엑트에 대한 숙달을 하게 되었습니다.

  공용 컴포넌트 제작, 학생 채점 및 수업 진도 관리, 학생 출결관리, 학생 관리, 선생님 관리 등을 작업하였습니다.

---

### 이트라이브

**재직 기간: 2016. 11 ~ 2018. 11 (2년 1개월)**

UX팀의 Scripter 프로젝트에 스크립트 로직, 사용자 인터렉션에 대한 스크립트, 애니메이션에 대한 스크립트로 활동을 했습니다.

**퇴사 사유**
재직 당시 SPA라는 개념이 대중화되면서 프론트엔드 직무에 대한 관심이 생겼습니다.
그 동안 퍼블리싱 한 페이지에 스크립트를 짜고 백엔드 로직과 섞이면서 굉장히 많은 커뮤니케이션 비용이 들었습니다.
백엔드 로직과 한 페이지 내에 섞이지 않는다는 점과 컴포넌트를 통해 재사용한다는 것이 제 심금을 울렸고, 해당 직무로 커리어를 발전시키고 싶어 퇴사했습니다.

- [**당시의 프로젝트들 포트폴리오 보기**](https://hoejun.s3.ap-northeast-2.amazonaws.com/portfolio/index.html)

  **Tech stack**
  gsap, jquery, javascript, swiper

  ux팀의 scripter로 활동하며 20개 이상의 프로젝트를 하였습니다.
  모든 프로젝트는 프로젝트당 스크립터 1인(본인 기여 100%)로 참여했습니다.

  그 중 작업량이 많았던 프로젝트들 위주로 포트폴리오에 담았습니다.

---

## 개인 프로젝트 및 학습

### 선언적 개발 환경과 홈랩

주요 기술: Nix, NixOS, Nix Flakes, SOPS, Comin, Hindsight, llama.cpp

- 2024년부터 Mac 개발 환경을 [Nix Flake 기반 dotfiles](https://github.com/rjcnd105/hj-dotfiles)로 관리하고 있습니다. 같은 방식을 NixOS 미니 PC에 적용하고 Comin으로 Git 변경을 배포하는 GitOps 흐름을 구성했습니다.
- 2026년부터 NixOs 기반의 홈랩에 Hindsight를 운영하고 로컬 llama.cpp 임베딩·리랭킹 모델을 연결해, 코딩 에이전트가 세션 밖의 프로젝트 맥락을 다시 찾을 수 있는 메모리 환경을 만들었습니다.
- Codex와 Claude Code가 저장소 규칙을 따르도록 프로젝트 지침, 스킬, MCP 도구와 검증 명령을 함께 관리합니다. AI가 코드를 많이 만드는 것보다 정확한 맥락과 짧은 피드백 루프를 갖는 데 초점을 둡니다.
- [comin](https://github.com/nlewo/comin)을 통해 git 을 통해서 두 시스템(mac, nixos homlab)을 선언적으로 관리합니다.

### Effect, 함수형 프로그래밍과 도메인 모델링

- 여러 작업이 동시에 진행되는 비동기 로직에서 실패가 예외로 숨지 않도록 성공, 실패, 취소와 재시도 경로를 값과 타입으로 드러내는 방법을 공부했습니다. Effect 개념을 중심으로 Scala의 Cats와 Cats Effect, Haskell, Rust의 처리 방식을 비교했습니다.
- 범주론(Category theory)를 공부하며 모나드(Monad)의 원리를 이해하고 직접 구현할 수 있습니다. 실무에서는 이 개념을 전면에 내세우기보다 Railway 프로그래밍적인 형식으로 실패 전파를 작은 함수와 명시적인 타입으로 풀어 팀이 읽을 수 있게 적용합니다. (ex: Result, Option)
- Scala의 Cats에서 배운 타입 중심 모델링과 Effect-TS Schema, fp-ts/schema의 인코딩·디코딩 방식을 참고해 Zod 스키마를 입력 검증 파일이 아니라 도메인의 상태와 변환 규칙을 담는 명세로 작성합니다.
- 도메인, 스키마, 비동기 흐름과 실패 조건을 명시해 두면 AI 에이전트가 추측해야 할 부분도 줄어듭니다. 실제 프로젝트에서 에이전트가 기존 구조를 더 잘 따라가고 수정 범위를 정확히 잡는 것을 경험했습니다.
- 함수형 프로그래밍적인 흐름과 도메인 개념을 결합하여 사람과 에이전트 양쪽에 친화적이면서 선언적인 프로그래밍으로 구성합니다. [참고](https://www.youtube.com/watch?v=2JB1_e5wZmU)

## 학력

### 동양미래대학교 · 컴퓨터소프트웨어정보과

2011.03 ~ 2016.02 · 학점 4.04/4.5

#### 수상 내역

**2015 삼성전자 SCSC-C 창의공학 경진대회 최우수상**

- 원격 조종·웹 영상 공유 라즈베리파이 CCTV의 웹 파트 개발 - 팀원

**2015 동양미래대학교 스마트 SW 개발 경진대회 최우수상**

- GPS 기반 SNS와 Google Maps를 결합한 스토리맵 개발 - 팀장

### 자격증·교육

#### 자격증

정보처기사(2020), 정보기기운용기능사(2012), 그래픽스운용기능사(2012)

#### 교육

패스트파이브 React 과정(2019), 그린컴퓨터아카데미 프론트엔드 과정(2016)

## 링크

- [프리윌린 직무 인터뷰](https://www.jobplanet.co.kr/companies/325950/feeds/3409?_rs_act=landing&_rs_con=companies&_rs_element=feed)
- [이전 인터랙션 포트폴리오](https://hoejun.s3.ap-northeast-2.amazonaws.com/portfolio/index.html)
