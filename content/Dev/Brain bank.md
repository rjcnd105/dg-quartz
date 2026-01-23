---
publish: true
created: 2025-11-22T06:26:14Z
modified: 2026-01-23T05:56:03Z
tags:
  - git
  - feature_flag
cssclasses: ""
---


떠오르는 주제들을 적어두고 추후 딥다이브

---

## Trunk base + Feature flag + ci test

git [Trunk ](https://www.atlassian.com/continuous-delivery/continuous-integration/trunk-based-development) 전략 기준

feature flag를 통해 제어되므로 개발 중인 기능이 main 브랜치에 병합되어도 문제가 생기지 않음.
각 feature flag는 전체 시스템(back, front, infra) 통합적

feature flag group이 있고 해당 그룹은 기본적으로 release, staging, dev의 구분을 지님
해당 feature flag group은 request url을 통해 구분

### 팀 지침

- PR 병합이 되지 않더라도 그로 인한 업무 지장이 가지 않도록 **git stacking** 전락을 사용 (e.g - jj, gitbutler)
- PR 확인하는 시간은 하루에 2번
  출근 직후, 4:00~4:30
- 300줄 미만의 작은 단위로 PR
- PR에 `Pass` 라벨을 붙혀서 책임 하에 코드 리뷰 없이 병합 가능(테스트는 통과해야함). 단, 팀원이 재량껏 사후 코드 리뷰를  할 수 있음.
- 매 브랜치는 하루 이내에 병합되어야 함 - 매일 아침 생성된지 하루 이상 지난 브랜치 존재시 마지막 커밋 팀원에게 슬랙 경고 알람

**git, pr 관련 툴**
git stacking tool
- [jj(Jujutsu)](https://github.com/jj-vcs/jj) - 스택 별로 쌓고 이전 스택에 커밋하면 쌓인 스택들이 자동으로 리베이스 됨
  [jjui](https://github.com/idursun/jjui)
  [jj workflow](https://ofcr.se/jujutsu-merge-workflow)

git 가상 브랜치 gui tools
- [gitbutler](https://gitbutler.com/)

git 효율성 솔루션
- [Graphite](https://graphite.com/) - 각 커밋을 레이어별로 쪼개서 분할 PR을 날림 (POC 필요). 구글의 전략을 기반으로 만들어짐, stacking 전략 지원 됨

### 필수 조건

1. feature flag를 통해 통제하여 개발 중인 기능을 main에 추가하더라도 문제가 생기지 않아야 함
   feature flag 별 가능한 버전 명시 필요?
	   TODO: feature flag group들을 한눈에 확인하고 각 그룹별로 설정하고 컨트롤 할 수 있는 페이지 필요 - 관련 솔루션 알아봐야함, 혹은 직접 구현?
2. main push event시 ci를 통해 빌드(dev) 및 테스트를 거침
3. main에 push event시 dev 배포, rc 태그 추가시 staging 배포,
   - **realease**
     릴리즈 태그 추가 후 release 배포 github action trigger 생성
     tag: `v1.12.3`
     image version tag: `:1.12.3`
     
   - **staging**
     rc 태그 지정시 staging 배포
     tag: `v1.12.3-rc.0`, `v1.12.3-rc.1`, ...
     latest tag: `v1.12.3-rc`
     image version tag: `:1.12.3-rc.0`
   
   - **dev**
     main에 push event마다 배포 (한번에 5개의 commit 추가시 맨 마지막 커밋)
	  latest tag: `dev`
	  image version tag: `:{date}.{shortSha}` (e.g `:20251122.b4723bd`)

### 추가 아이디어

- **URL로 feature flag group 인식**
  dev 서버는 하나이나 여러 논리적 분기(feature flag group)를 둠
  해당 논리적 분기를 기반으로 feature flag 설정
  해당 논리적 분기는 feature flag group을 추가하면 얼마든지 생성 가능
  ex) www.A.dev.myapp.com, www.B.dev.myapp.com, www.C.dev.myapp.com
  위 A, B, C 라는 feature flag group을 각각에 feature flag들을 다르게 설정하여 테스트 할 수 있음
  예제 이미지
	![[env/첨부파일/CleanShot 2025-12-03 at 11.01.45.jpg|400]]

## 백엔드 OpenApi Spec 변경시 ai로 이전과 diff하여 프론트엔드에 PR

매번 api 바뀌는 것  대응하기 힘들다..

## Sentry 에러로부터 ai 통해서 Review 및 PR

해당 문제에 대한 수정사항을 어떻게 고유화할 것이냐가 핵심.
예를 들어 특정 공유 컴포넌트의 문제로 인해 여러 페이지에서 에러가 발생했을시 이것을 각각의 에러가 아닌 해당 컴포넌트에 대한 문제인 것을 인식할 수 있어야 함.

## 디자인 시스템 토큰화 + AI Agent SKILL로 등록

당근 디자인 시스템 https://github.com/daangn/seed-design 참고. 다만 yaml은 싫다..
cue, pkl, nickel로 할 수는 없을까? - 디자인 시스템 명세라면 cue가 가장 적합해보이기는 함

## 선언적 VPS stack

### 초기

NixOs + nix packages의 DockerTools을 사용한 nix 언어로 Docker 선언
Comin으로 GitOps 기반으로 구성하며 sops-nix를 통해 비밀 관리
외부 클라우드 설정은 개별 cli 툴을 사용함.

### 목표

위의 Comin + sops-nix와 더불어 NixOs + Nix의 k3s 설정으로 마이그레이션 한다.
docker 기반의 설정을 kuberneties로 변경, 외부 클라우드 기반 설정은 terraform으로 변경
