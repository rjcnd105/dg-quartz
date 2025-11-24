---
{"publish":true,"created":"2025-11-22T06:26:14Z","modified":"2025-11-24T01:11:09Z","tags":["git","feature_flag"],"cssclasses":""}
---


떠오르는 주제들을 적어두고 추후 딥다이브

---

## Trunk base + Feature flag + ci test

git [Trunk ](https://www.atlassian.com/continuous-delivery/continuous-integration/trunk-based-development) 전략 기준
매 커밋 별 dev 배포를 피하기 위한다면 github flow 와 같은 단순한 형태의 브랜치 전략 사용

feature flag를 통해 제어되므로 개발 중인 기능이 main 브랜치에 병합되어도 문제가 생기지 않음.
각 feature flag는 전체 시스템(back, front, infra) 통합적

feature flag group이 있고 해당 그룹은 기본적으로 release, staging, dev의 구분을 지님
해당 feature flag group은 request url을 통해 구분

### 필수 조건

1. 개발 중인 기능을 main에 추가하더라도 문제가 생기지 않아야 함 (feature flag를 통해 통제되므로)
   feature flag 별 가능한 버전 명시 필요? (front, back)
   TODO: feature flag group들을 한눈에 확인하고 각 그룹별로 설정하고 컨트롤 할 수 있는 페이지 필요 - 관련 솔루션 알아봐야함, 혹은 직접 구현?
2. main push event시 ci를 통해 빌드(dev) 및 테스트를 거침
3. main에 push event시 dev 배포, release/{version} 브랜치 push event시 staging 배포
   - **realease**
     staging으로 확인하고 문제 없는 경우 트리거 액션으로 배포
     tag: `v1.12.3`
     image version tag: `:1.12.3`
     
   - **staging**
     `release/v1.12.3` 에 push event 마다 배포
     tag: `v1.12.3-rc.0`, `v1.12.3-rc.1`, ...
     latest tag: `v1.12.3-rc`
     image version tag: `:1.12.3-rc.0`
   
   - **dev**
     main에 push event마다 배포 (TOOD: 각 버전에 대한 dev 배포가 필요할지?? (e.g `v.1.12.0-dev.20251122`)
	  latest tag: `dev`
	  image version tag: `:{date}.{shortSha}` (e.g `:20251122.b4723bd`)

### 추가 아이디어

- **URL로 feature flag group 인식**
  dev 서버는 하나이나 여러 논리적 분기(feature flag group)를 둠
  해당 논리적 분기를 기반으로 feature flag 설정
  해당 논리적 분기는 feature flag group을 추가하면 얼마든지 생성 가능
  ex) www.A.dev.myapp.com, www.B.dev.myapp.com, www.C.dev.myapp.com
  위 A, B, C 라는 feature flag group을 각각에 feature flag들을 다르게 설정하여 테스트 할 수 있음
