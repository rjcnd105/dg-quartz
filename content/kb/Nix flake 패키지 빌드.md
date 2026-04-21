---
publish: true
created: 2026-04-08T02:47:00Z
modified: 2026-04-08T02:47:00Z
tags:
  - kb
  - nix
  - flake
  - build
---

Nix flake으로 소프트웨어 패키지를 빌드하는 패턴. 언어별 빌더(`buildGoModule`, `buildNpmPackage` 등)를 사용하여 [[결정론적 빌드]]를 달성.

## 핵심 내용

Nix flake에서 패키지를 정의하면 빌드 입력이 모두 해시로 고정됨. `nix build`로 로컬 빌드, 결과물을 Docker 이미지나 NixOS 시스템에 포함 가능.

Go 앱 예시 (출처: [[Nix is a better Docker image builder than Docker's image builder]]):

```nix
bin = pkgs.buildGoModule {
  pname = "douglas-adams-quotes";
  inherit version;  # git commit에서 자동 생성
  src = ./.;
  vendorHash = null;  # 외부 의존성 없을 때. 있으면 해시 지정 또는 gomod2nix 사용
};
```

**외부 의존성 관리**: `vendorHash`에 의존성 전체의 해시를 지정하거나, `gomod2nix`(https://github.com/nix-community/gomod2nix)로 자동화.

**빌드 결과를 Docker 이미지로**: `pkgs.dockerTools.buildImage`로 Nix 패키지를 최소 Docker 레이어로 변환. 변경분만 push되어 CI/CD 효율 극대화.

## 관련 링크

- [[결정론적 빌드]] — 이 패턴이 보장하는 핵심 속성
- [[Nix 기반 Docker 이미지 빌드]] — 빌드 결과를 Docker로 패키징
- 관련 vault 노트: [[basic|Nix basic]], [[concept learning]]
