---
publish: true
title: 김회준 · Frontend Engineer - 검토본
created: 2026-09-09
modified: 2026-10-19T06:36:42Z
tags:
  - 이력서
  - frontend
  - fullstack
  - 검토본
---

7년 차 프론트엔드 엔지니어로서 팀의 기술 선도적인 역할을 담당하였습니다.
제품이 커진 뒤에도 팀과 에이전트가 구조를 이해하고 기능을 계속 바꿀 수 있도록 도메인과 레이어의 경계를 잡는 일이 제 강점입니다.
주도적으로 제품 개발에 참여하는 것을 좋아합니다. 제가 만드는 제품에 대해 스스로 높은 기준을 가지고 있습니다.
이를 바탕으로 제품에 현재 필요한 것이 무엇인지 빠르게 파악하고, 제가 기여할 수 있는 지점을 주도적으로 찾아 제품의 퀄리티를 높이는 데 집중합니다.

[GitHub](https://github.com/rjcnd105) · [Blog](https://rjcnd105.github.io/dg-quartz/) · [Email](mailto:rjcnd123@gmail.com)

## 기술

- **주력**: TypeScript, React, Next.js, CSS, HTML
- **라이브러리**: TanStack Query, React Hook Form, Tailwind CSS, Emotion, Storybook, tRPC, Prisma, D3.js(visx), Sentry
- **에이전트**: [pi](https://github.com/earendil-works/pi)(GPT, OpenRouter), Claude(pi-intercom을 통한 pi advisor)

**개발 철학**

- 리소스와 가능한 행위, 제약을 코드에 명시해 사람과 AI 에이전트가 같은 구조를 읽고 작업 맥락을 이어가도록 하며, 에이전트에게는 `Code is the spec`처럼 동작합니다. 사람의 검토는 비동기로 진행해 병목이 되지 않게 하고, 여러 에이전트(MoA)와 하네스를 조정하며 workflow를 계속 다듬고 있습니다.
- 유저와 직접 맞닿는다는 책임이 늘 있습니다. Frontend enginer로서 UI·UX·Interaction 까지 고민하고 개선합니다.
- DX 개선에 관심이 많아 팀 전체의 업무 효율을 높이는 데 큰 성취감을 느낍니다.

## 업무 히스토리

**프리윌린**

- 초창기 멤버로써 프론트엔드 팀 내부 문화인 KPT, 회고, 팀 업무 관리, 오프라인 코드리뷰, 스터디 등을 구성하고 주도한 경험이 있습니다.
- monorepo를 구성하고 프로젝트 레이어의 책임과 경계를 명확히 하여 프론트엔드 아키텍쳐 전반을 책임졌습니다.
- Headless·Compound Component 패턴을 활용해 재사용 가능한 공용 컴포넌트를 만들고, 디자인 시스템을 개발하고 공통 스타일의 기준으로 관리했습니다.

**아이아이컴바인드**

- OAuth 2.0, MFA(2단계 인증), SSO 기반의 인증을 구현했습니다. 토큰·세션 만료, 안전한 리다이렉트와 브라우저 노출 정보에 대한 프론트엔드에서의 보안적인 책임도 수행했습니다.
- 다양한 국가와 법인 오픈 과정에서 국제화, locale routing, i18n 흐름을 다뤘습니다.

**두디스**

- OpenApi spec을 기반한 type generate를 하여 사용하고, node 기반 서버의 경우 tRPC로 end to end typesafe 처리를 하였습니다.
- Prisma 기반으로 1인 풀스택 개발자로 앱을 개발하여 국가지원 사업에 통과하였습니다.

---

## 개인 프로젝트

### 선언적 개발 환경 구성 · [hj-dotfiles](https://github.com/rjcnd105/hj-dotfiles)

**Teck Stack**: Nix Flakes, nix-darwin, NixOS, Home Manager, sops-nix, Comin, Podman Quadlet, Ollama, Go lang

- <u>Mac</u>(nix-darwin)과 <u>홈랩</u>(개인 서버 및 미니 PC - NixOS)의 패키지·설정·서비스를 Flake 하나에 선언합니다.
- 코드, Git 기반으로 시스템이 구성되어 바로 롤백할 수 있고, main에 push하면 Comin이 홈랩에 자동 적용합니다.
- 시스템 전체가 코드라 에이전트가 다루기도 쉽습니다. Codex·Claude Code·Cursor의 규칙·스킬도 결정론적 파일 시스템으로 구성되어 에이전트가 스스로 복구하고 비교 측정할 수 있습니다.
- 앱은 런타임 계약(이미지·비밀·DB·LLM 모델)만 선언하면 호스트가 Podman Quadlet 유닛·Caddy 라우팅·Cloudflare Tunnel·DB를 생성합니다. 컨테이너는 systemd 서비스로 돌아 준비 순서·재시작·로그를 Docker 데몬 없이 관리하고, 릴리스는 Go로 작성한 `homelab-appctl`이 migrate·smoke까지 한 번에 처리합니다.
- 홈랩에 Ollama로 OCR용 [`PaddleOCR-VL-1.6-GGUF`](https://huggingface.co/PaddlePaddle/PaddleOCR-VL-1.6-GGUF)와 구조화용 [`Spark-X2.5-4B-Q8_0`](https://huggingface.co/XHToken/Spark-X2.5-4B-GGUF) 모델을 띄워 앱에서 사용합니다.

### 덮집회의 · [app.deopjib.cc](https://app.deopjib.cc/room/create)

**Teck Stack**: Elixir, Typescript, Phoenix Framework, Ash Framework, Oban, PostgreSQL, Ollama, React 19,  TanStack Router·Query

공동으로 복잡한 결제 내역을 적으면 최적화된 알고리즘(Greedy Debt Simplification) 을 통해 최소한의 송금을 할 수 있게끔 할 수 있는 앱입니다.
백엔드·프론트엔드·배포를 직접 개발해 위 홈랩에서 운영합니다.

- Ash Framework로 리소스 기반으로 action·validation·제약을 먼저 선언하고, Ash TypeScript RPC를 통해 Type, Zod 스키마를 파생하여 Generate되는 에이전트 친화적인 명세 기반 구성입니다.
- **결제 내역 이미지 인식**: 홈랩에 띄운 PaddleOCR-VL(OCR)과 Spark(구조화) 모델로 은행·카드 앱 스크린샷의 결제 내역을 자동으로 채웁니다. 스크린샷을 libvips로 한 줄씩 잘라 OCR한 뒤 JSON schema로 결제 항목을 뽑고, 작은 모델이 자주 틀리는 입금·취소 구분과 날짜는 코드 규칙으로 보정합니다.

---

## 상세 경력 사항

경력 사항은 날짜 내림차순으로 작성되었습니다.

### 아이아이컴바운드(젠틀몬스터)

Frontend Engineer · 계약 | 2025.04–2025.05, 2025.06-현재 (1년 8개월)

**Teck stack**: nextjs, TanSack Query, tailwind, framer motion

#### 젠틀몬스터 · 글로벌 커머스

- 메인 페이지의 주요 콘텐츠를 CSR에서 SSR로 전환 및 렌더링 최적화(LCP 2s -> 0.2~0.4s), 제품 리스트, 전반적인 퍼포먼스 최적화, 리펙토링
- nextjs 서버 메모리 최적화
- Google Maps·Baidu Maps 기반 매장 화면의 렌더링을 개선했습니다.
- **국제화(법인 오픈)** 중국·일본·호주·싱가포르·대만 등 해외 법인 오픈에 맞춰 언어·통화와 법인별 비즈니스 로직을 개발했습니다.
- SSR·ISR·CSR의 적용 기준과 프론트엔드 보안 가이드를 작성했습니다.

#### PS Admin (Product Service Admin)

삼성 AS 담당자, 젠틀몬스터 매장 직원, 본사 PS 담당자가 사용하는 제품·고객·티켓·재고 관리 시스템입니다. Google·삼성·젠틀몬스터가 공동 개발한 스마트 글래스의 수리 업무도 지원합니다. 프론트엔드 설계와 개발을 80% 담당했습니다.

- OpenAPI에서 생성한 TypeScript 타입을 기준으로 API를 연결하고, DDD, Feature-Sliced 기반한 구조와 Schema 기반(Zod) 으로 구조를 구축했습니다.
- 여러 재고 요청의 상태를 한 번에 바꿀 때, 선택한 요청 모두에 허용되는 상태만 표시하도록 구현했습니다. 종료된 요청과 서로 다른 상태가 섞이는 경우를 Vitest 테스트로 검증했습니다.
- 계정의 읽기·쓰기·삭제 권한에 따라 메뉴와 기능 접근을 제어하고, next-intl로 다국어 메시지를 연결했습니다.

---

### 프리윌린

Frontend Engineer |  2019. 8 ~ 2022. 2, 2023.8 ~ 2023.12 (총 3년)

개발 팀 전체 4명이던 시절부터 합류한 초창기 멤버로서, 회사가 커져감에 따라 프론트엔드(6명) 팀에 여러 문화(코드리뷰, 회고, KPT, 개발 발표회, 퇴근 후 스터디, Personal Review, 핵심 기능 개발 완료 후 리뷰 등)를 주도하에 만들고 지속적인 디벨롭하며 이끌었습니다.

네이티브 앱만 있을때 입사해서 웹 버전을 개발하고 알토스 시리즈A 투자를 받았으며 현재의 매쓰플랫2, 학생 앱(웹앱으로 앱 대체)까지 개발 완료 했습니다.

퇴사 후에도 회사로부터 연락 받아 계약직으로 일했습니다.

**Tech stack**
react, typescript, mobx, emotion, storybook, react-hook-form, react-query

**퇴사 사유**
조직이 커지면서 업무 방식이 점점 워터폴화 되고 주도적으로 일할 수 있는 파이가 점점 줄어드는 것을 느꼈습니다.
또 의사 결정 단계가 많아지고 과정이 복잡해져서 빠르게 새로운 시도를 해보기 어려운 환경이 되었습니다.
그래서 **새로운 시도를 할 수 있는 문화, 주도적으로 일할 수 있는 환경**에서 일하고 싶은 갈증이 느껴져서 퇴사하게 되었습니다.

#### Projects

##### 모노레포 전환, 아키텍쳐 및 Workflow 설계, 학생 앱 개발

기존 제품 리뉴얼의 아키텍처·프로젝트 설계 담당으로 계약했습니다. (2023.08.08~2023.12.29)
\- 모노레포로 전환하고, 기존 문제점을 팀과 논의해 개발 컨벤션과 작업 방식을 정했습니다.
\- DDD·Hexagonal·Clean·Feature-Sliced를 부분 적용해 core(도메인)·service(trait)·ui(feature) 레이어로 나눴습니다. 도메인은 스키마로 정의하고 인코딩·디코딩과 에러 처리를 정형화해, 별도 어댑터 레이어 없이 Port에만 의존하게 했습니다.
\- 여러 도메인에 공통인 동작은 Rust의 trait 개념으로 분리해 하위 레이어가 도메인 대신 trait에 의존하게 했고, 서비스 레이어는 Facade로 비즈니스 로직 간 의존을 줄였습니다.
\- 코어 모듈·라이브러리와 스타일을 주입받아 프로젝트별 테마를 적용하는 Headless·Compound Component를 개발하고, 이를 사용해 학생 자기주도학습 기능을 개발했습니다.

##### Mathflat2 구축

**개요**
기존의 네이티브 앱으로 되어있든 Mathflat1을 하이브리드 앱으로 대체하는 Mathflat2를 새롭게 만들었습니다.
태블릿을 통해 프린터 서버를 통해 보고서를 프린터로 바로 뽑는 케이스가 많았으므로 네이티브 앱으로 감싼 웹앱으로 했습니다.
재직시 약 2000개의 학원에서 사용되었습니다.

**개발 사항**
프로젝트 아키텍처와 구조, 개발 규칙을 정했습니다.
공용 컴포넌트 비중을 높이고, 코어 컴포넌트를 단계적·부분적으로 확장해 파생 컴포넌트를 만드는 패턴을 적용했습니다.
구형 태블릿의 웹앱 성능 문제에 대응해 번들 크기, 데이터·React Query 캐싱, 컴포넌트 렌더링, 레이아웃 시프트를 최적화했습니다.

##### PDF Generator 운영, 피쳐, 리뉴얼

**Tech stack**
puppeteer, react, typescript, emotion, c3

**개요**
매쓰플랫으로부터 학생의 교재, 학습지 진도와 성적을 기반으로 종합 보고서를 만드는 puppeteer를 이용한 보고서 pdf 제네레이터입니다.

**개발 사항**
보고서 디자인 개편에 맞춰 레거시 코드를 전부 리팩터링해 JS -> TypeScript 및 컴포넌트로 분리하고, 스타일을 모듈화했습니다.

##### Mathflat1 구축

팀원: 기획•디자이너 1명, 백엔드 2명, 퍼블1∙프론트엔드 2명 - **본인 기여 40%**

**Tech stack**
react, styled-component, mobx

**개요**
Mathflat이라는 수학 선생님을 위한 웹 종합 솔루션을 제작하였습니다.
기존에 앱으로 있던 것을 웹버전으로 만들면서 웹 환경에 적합하게 앱과 다르게 디벨롭되었습니다.
학생, 반, 선생님 관리, 출결 관리, 문제 관리, 학습지 만들기, 교재 만들기, 숙재내기 (학생 앱으로 숙제 나감) 학생의 진도와 점수 채점, 관리. 학생의 성적에 대한 보고서를 출력할 수 있는 프로덕트 입니다.

---

### 여행의 기술(텔레스코프)

Frontend Engineer · 계약 |  2024.5 ~ 2024.11 (6개월)

**Teck stack**
Next.js, TypeScript, React, TanStack Query, Tailwind CSS, Naver Maps API, Strapi, OpenAPI

[여행의 기술](https://apps.apple.com/kr/app/%EC%97%AC%ED%96%89%EC%9D%98%EA%B8%B0%EC%88%A0/id6479636679)는 여행지·맛집·카페를 탐색하고 여행 플랜을 만들어 공유하는 하이브리드 앱입니다.

- 여행 플랜의 생성·편집·공유 전반을 개발했습니다. 여러 날짜에 걸친 장소 재정렬과 다중 이동·삭제를 하나의 편집 모델로 다루고, 화면의 편집 상태와 서버 저장 시점을 분리해 복잡한 변경을 안정적으로 처리했습니다. 일정과 스크롤 위치에 맞춰 마커와 지도 영역을 동기화하고, 많은 마커와 잦은 화면 전환에서도 불필요한 렌더링과 지도 인스턴스가 누적되지 않도록 성능을 최적화했습니다.
- GPS 기반 장소 검색 및 위시리스트 기능을 개발 했습니다.
- 여러 화면에서 현재 작업을 유지한 채 장소 상세를 확인할 수 있는 nextjs parallel routes(with iframe) 바텀시트를 개발했습니다. 브라우저 히스토리와 직접 진입·뒤로가기 동작, 중첩 모달, iOS WebView의 레이아웃·스크롤 예외를 함께 해결했습니다.

[여행 플랜 운영 환경 사용 영상](https://rjcnd105.github.io/dg-quartz/env/%EC%B2%A8%EB%B6%80%ED%8C%8C%EC%9D%BC/my-jeju-plan1.mp4)

---

### 프리윌린

Frontend Engineer |  2019. 8 ~ 2022. 2, 2023.8 ~ 2023.12 (총 3년)

개발 팀 전체 4명이던 시절부터 합류한 초창기 멤버로서, 회사가 커져감에 따라 프론트엔드(6명) 팀에 여러 문화(코드리뷰, 회고, KPT, 개발 발표회, 퇴근 후 스터디, Personal Review, 핵심 기능 개발 완료 후 리뷰 등)를 주도하에 만들고 지속적인 디벨롭하며 이끌었습니다.

네이티브 앱만 있을때 입사해서 웹 버전을 개발하고 알토스 시리즈A 투자를 받았으며 현재의 매쓰플랫2, 학생 앱(웹앱으로 앱 대체)까지 개발 완료 했습니다.

퇴사 후에도 회사로부터 연락 받아 계약직으로 일했습니다.

**Tech stack**
react, typescript, mobx, emotion, storybook, react-hook-form, react-query

**퇴사 사유**
조직이 커지면서 업무 방식이 점점 워터폴화 되고 주도적으로 일할 수 있는 파이가 점점 줄어드는 것을 느꼈습니다.
또 의사 결정 단계가 많아지고 과정이 복잡해져서 빠르게 새로운 시도를 해보기 어려운 환경이 되었습니다.
그래서 **새로운 시도를 할 수 있는 문화, 주도적으로 일할 수 있는 환경**에서 일하고 싶은 갈증이 느껴져서 퇴사하게 되었습니다.

#### Projects

##### 모노레포 전환, 아키텍쳐 및 Workflow 설계, 학생 앱 개발

기존 제품 리뉴얼의 아키텍처·프로젝트 설계 담당으로 계약했습니다. (2023.08.08~2023.12.29)
\- 모노레포로 전환하고, 기존 문제점을 팀과 논의해 개발 컨벤션과 작업 방식을 정했습니다.
\- DDD·Hexagonal·Clean·Feature-Sliced를 부분 적용해 core(도메인)·service(trait)·ui(feature) 레이어로 나눴습니다. 도메인은 스키마로 정의하고 인코딩·디코딩과 에러 처리를 정형화해, 별도 어댑터 레이어 없이 Port에만 의존하게 했습니다.
\- 여러 도메인에 공통인 동작은 Rust의 trait 개념으로 분리해 하위 레이어가 도메인 대신 trait에 의존하게 했고, 서비스 레이어는 Facade로 비즈니스 로직 간 의존을 줄였습니다.
\- 코어 모듈·라이브러리와 스타일을 주입받아 프로젝트별 테마를 적용하는 Headless·Compound Component를 개발하고, 이를 사용해 학생 자기주도학습 기능을 개발했습니다.

##### Mathflat2 구축

**개요**
기존의 네이티브 앱으로 되어있든 Mathflat1을 하이브리드 앱으로 대체하는 Mathflat2를 새롭게 만들었습니다.
태블릿을 통해 프린터 서버를 통해 보고서를 프린터로 바로 뽑는 케이스가 많았으므로 네이티브 앱으로 감싼 웹앱으로 했습니다.
재직시 약 2000개의 학원에서 사용되었습니다.

**개발 사항**
프로젝트 아키텍처와 구조, 개발 규칙을 정했습니다.
공용 컴포넌트 비중을 높이고, 코어 컴포넌트를 단계적·부분적으로 확장해 파생 컴포넌트를 만드는 패턴을 적용했습니다.
구형 태블릿의 웹앱 성능 문제에 대응해 번들 크기, 데이터·React Query 캐싱, 컴포넌트 렌더링, 레이아웃 시프트를 최적화했습니다.

##### PDF Generator 운영, 피쳐, 리뉴얼

**Tech stack**
puppeteer, react, typescript, emotion, c3

**개요**
매쓰플랫으로부터 학생의 교재, 학습지 진도와 성적을 기반으로 종합 보고서를 만드는 puppeteer를 이용한 보고서 pdf 제네레이터입니다.

**개발 사항**
보고서 디자인 개편에 맞춰 레거시 코드를 전부 리팩터링해 JS -> TypeScript 및 컴포넌트로 분리하고, 스타일을 모듈화했습니다.

##### Mathflat1 구축

팀원: 기획•디자이너 1명, 백엔드 2명, 퍼블1∙프론트엔드 2명 - **본인 기여 40%**

**Tech stack**
react, styled-component, mobx

**개요**
Mathflat이라는 수학 선생님을 위한 웹 종합 솔루션을 제작하였습니다.
기존에 앱으로 있던 것을 웹버전으로 만들면서 웹 환경에 적합하게 앱과 다르게 디벨롭되었습니다.
학생, 반, 선생님 관리, 출결 관리, 문제 관리, 학습지 만들기, 교재 만들기, 숙재내기 (학생 앱으로 숙제 나감) 학생의 진도와 점수 채점, 관리. 학생의 성적에 대한 보고서를 출력할 수 있는 프로덕트 입니다.

---

### 젤리페이지

Web Frontend 테크 리드 · 프론트엔드 4인 팀 | 2023.03–2023.06 (3개월)

**Teck stack**
Next.js, TypeScript, Turborepo, pnpm, Zod, TanStack Query, Storybook

- 독서 앱 JellyPage2, 학습 서비스 JellyReading, JellyReading CMS의 프론트엔드 구조를 설계했습니다. 모노레포에서 공통 로직·스타일·컴포넌트 패키지를 분리하고 도메인 스키마를 정의했습니다.
- JellyPage2의 Next.js 서버에서 Google·Apple·Naver·Kakao 등 로그인 연동과 토큰 처리를 개발했습니다. 회원 전환·통합·탈퇴·가입 등 여러 회원 상태와 온보딩 단계의 분기를 구현했습니다.
- 테스트, 서버·클라이언트 컴포넌트 구분, 라우팅 등의 개발 기준을 정하고 팀에 공유했습니다. 세 프로젝트의 일정에 따라 공통 모듈과 기능 개발을 병행했습니다.

**퇴사 사유**
모 회사의 압박에 의해 평일 새벽, 주말 내내 이어지는 근무로 인해 건강이 악화되었습니다.
1달 후 회사는 사라졌습니다.

---

### 두디스

Frontend · Fullstack Engineer 계약 | 2022.7 ~ 2023.01 (6개월)

메인 프로덕트 전체 frontend project 설계 & 개발, prisma를  사용한 데이터베이스, 백엔드 비즈니스 로직 작성
turborepo를 도입하여 monorepo프로젝트로 변환

**Teck stack**
nextjs, ts, postcss, tailwind, ts-rest, fp-ts, zod, valtio, iron-session, storybook, visx, pwa, prisma, trpc,

**퇴사 사유**
프로젝트를 성공적으로 마치고 지원사업에 통과했으며 계약상의 종료입니다.

#### Projects

##### 소재 찾기

팀원: PO 1명, 기획자 1명, 디자이너 1명, 백엔드 1명, **프론트엔드 1명(본인)**

**개요**
대시보드에 통계와 그래프, 최신의 트랜드를 통하여 크리에이터의 의사결정을 도와주는 AI, 빅데이터 기반의 시스템입니다.

**개발 사항**
svg, visx(d3) 기반하여 그래프를 그렸습니다.
nextjs의 appDir을 통한 nested layout을 활용하며 nestjs를 사용하는 백엔드 개발자와의 도메인을 맞추기 위해 공통 라이브러리를 사용하며 zod Schema, ts-rest Contrect(API Route)를 공유합니다.
이로 인해 불필요한 커뮤니티 비용의 절감과 typesafe한 RPC 통신을 할 수 있었습니다.

##### 요청 프로젝트

팀원: PO 1명, 데이터 1명(devops, 인증, 약간의 비즈니스 로직), 백엔드 비즈니스 로직 (2인, **본인 기여도 80%**), **프론트엔드 1인(본인)**

**개요**
크리에이터한테 펀딩금을 걸고 글과 이미지를 통해 컨텐츠를 요청하고 다른 사람이 펀딩한 것에 펀딩하고 크리에이터의 심사 과정을 거쳐 요청이 거절되거나 승락될 수 있는 프로젝트 입니다.

**개발 사항**
백엔드 개발자가 따로 없이 nextjs, prisma 이용한 전체 백엔드 비즈니스 로직 개발, api 설계를 했습니다.
그리고 trpc를 통해 nextjs 서버와 클라이언트 간에 RPC 통신을 하였으며 zod schema 스키마를 통한 벨리데이션, typesafety, transform의 효과를 챙겼습니다.
댓글 작성 및 에디터를 통한 글 작성, 이미지 aws에 업로드, 한글 검색 및 검색 결과 URL을 통한 유지. 검색 결과에 매칭되는 글들 하이라이팅 등을 작업했습니다

---

### 이트라이브

**재직 기간: 2016. 11 ~ 2018. 11 (2년 1개월)**

UX팀의 Scripter 프로젝트에 스크립트 로직, 사용자 인터렉션에 대한 스크립트, 애니메이션에 대한 스크립트로 활동을 했습니다.

- [**당시의 프로젝트들 포트폴리오 보기**](https://hoejun.s3.ap-northeast-2.amazonaws.com/portfolio/index.html)

---

<div style="page-break-after: always;"></div>

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
