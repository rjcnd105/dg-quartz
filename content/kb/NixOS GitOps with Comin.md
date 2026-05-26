---
publish: true
created: 2026-04-08T02:40:00Z
modified: 2026-04-08T02:40:00Z
tags:
  - kb
  - nix
  - nixos
  - gitops
  - comin
---

Comin은 NixOS용 GitOps 에이전트. 각 노드에서 git repo를 폴링하고 구성을 자동 적용하여 `nixos-rebuild switch` 수동 실행을 불필요하게 만든다.

## 핵심 내용

ArgoCD가 Kubernetes에서 하는 것을 Comin이 NixOS 베어메탈에서 한다. git push → 1분 내 모든 노드 자동 업데이트 (출처: [[Vanilla Kubernetes on NixOS  Marius' Homepage]]).

```nix
services.comin = {
  enable = true;
  remotes = [{
    name = "origin";
    url = "https://github.com/m4r1vs/NixConfig.git";
    branches.main.name = "main";
  }];
};
```

Linux 커널 업데이트, K8s 버전 업, SSH 키 교체 등 모든 변경이 git push 하나로 전파.

## 실전 사용

Hetzner arm64 VPS 3대 (월 5유로/노드)에서 K8s 클러스터를 운영하는 사례. 3개 호스트를 `default.nix`에 정의하고, 공통 `kubernetes.nix` 모듈을 공유. 호스트명/IP만 다름.

**주의점**: 2025년 기준 NixOS + K8s 컨테이너 런타임 설정은 까다로움. containerd 및 네트워크 플러그인(Flannel) 조정이 필요.

## 관련 링크

- [[Nix 기반 Docker 이미지 빌드]] — 빌드 측면
- [[Quadlet]] — K8s 없이 컨테이너를 관리하는 가벼운 대안
- Comin GitHub: https://github.com/nlewo/comin
- 실전 NixConfig: https://github.com/m4r1vs/NixConfig
