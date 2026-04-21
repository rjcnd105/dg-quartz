---
publish: true
created: 2026-04-08T02:47:00Z
modified: 2026-04-17T08:00:00Z
tags:
  - kb
  - nix
  - nixos
  - modules
  - infrastructure
---

여러 NixOS 호스트가 공통 모듈을 공유하면서 호스트별 차이만 분리하는 구성 패턴.

## 핵심 내용

여러 노드가 거의 동일한 구성을 공유할 때, 공통 부분을 모듈로 추출하고 호스트별 차이만 개별 정의한다 (출처: [[Vanilla Kubernetes on NixOS  Marius' Homepage]]).

```
hosts/
  default.nix       # 3개 호스트 정의, 공통 모듈 import
  kubernetes.nix     # K8s 공통 구성
  falkenberg.nix     # 호스트명, IP만 다름
  stadeln.nix
  ronhof.nix
```

**차별화 축**: 보통 hostname, IP, 네트워크 인터페이스 정도만 다름. 나머지(K8s 설정, 커널, 패키지, SSH 키)는 공통 모듈에서 관리.

**Quadlet 스택에서의 활용**: 홈랩에서 여러 서비스 스택을 `stacks/` 하위에 각각 Nix 파일로 분리 (출처: [[Goodbye Docker, hello Quadlet]]). 각 스택이 독립 모듈이지만 공통 네트워크/볼륨 규칙을 상속.

### Dendritic Pattern: 구현 방식 중 하나

[[Dendritic Pattern]]은 공유 메커니즘을 구조에 위임한 구체적 구현 (출처: [[How to structure your NixOS config]]). `import-tree`로 `modules/` 하위를 auto-import하고, `flake.nixosModules.<name>` 동일 이름을 자동 병합. 호스트별 차이는 `modules/hosts/<host>/<host>.nix`에서 모듈 이름 나열로만 표현.

## 관련 링크

- [[Dendritic Pattern]] — auto-import + flake-parts로 구현한 dendritic 변형
- [[NixOS GitOps with Comin]] — 이 패턴의 변경 사항을 자동 배포
- 관련 vault 노트: [[basic|Nix basic]], [[concept learning]]
- 실전 예시: https://github.com/m4r1vs/NixConfig, https://github.com/Keyruu/shinyflakes, https://github.com/FilipRuman/NNC
