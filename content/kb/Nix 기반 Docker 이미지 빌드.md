---
publish: true
created: 2026-04-08T02:40:00Z
modified: 2026-04-08T02:40:00Z
tags:
  - kb
  - nix
  - docker
  - ci-cd
  - deterministic-build
---

Nix로 Docker 이미지를 빌드하면 결정론적이고 최소한의 레이어를 가진 이미지를 얻는다. Docker 빌드의 비결정성 문제를 해결하는 접근법.

## 핵심 내용

**Docker 빌드의 문제** (출처: [[Nix is a better Docker image builder than Docker's image builder]]):

- 비결정적: 빌드 중 인터넷 접근 → 같은 Dockerfile이라도 시점에 따라 다른 결과
- `apt-get upgrade`의 shadow copy로 불필요한 디스크 사용
- 베이스 이미지 EOL 시 재현 불가 (Ubuntu 18.04 등)
- 이 문제는 주로 새벽 4시에 발생 (SRE 경험담)

**Nix의 이점**:

- 모든 의존성을 사전 해시 → 동일 입력이면 동일 출력
- 의존성 트리 분석 → 최소 Docker 레이어로 패키징
- 코드 한 줄 변경 시 변경분만 push
- 인터넷 연결 없이 빌드 가능

## 실전 사용

Go 앱을 Nix로 빌드하여 Docker 이미지로 만드는 예시:

```nix
bin = pkgs.buildGoModule {
  pname = "douglas-adams-quotes";
  inherit version;
  src = ./.;
  vendorHash = null;
};
```

**도입 전략**: 기존 CI/CD를 바꾸지 않고 Docker 이미지 빌드만 Nix로 교체하는 것이 최소 진입점. Fly.io, Railway, Google Cloud Functions 등 Docker 이미지를 받는 플랫폼에서 바로 사용.

외부 Go 의존성이 있으면 `vendorHash`를 지정하거나 `gomod2nix`(https://github.com/nix-community/gomod2nix)로 자동화.

## 관련 링크

- [[Quadlet]] — 빌드가 아닌 실행 측면의 Nix+컨테이너
- [[NixOS GitOps with Comin]] — NixOS 인프라 전체를 선언적으로 관리
- 관련 vault 노트: [[basic|Nix basic]], [[concept learning]]
