---
publish: true
created: 2026-04-17T08:00:00Z
modified: 2026-04-17T08:00:00Z
tags:
  - kb
  - nix
  - nixos
  - flake
  - architecture
---

NixOS 설정을 flake-parts와 auto-import 기반으로 구성하는 패턴. `modules/` 하위 `.nix` 파일이 자동 import되고, `flake.nixosModules.<name>`으로 선언한 모듈이 같은 이름끼리 자동 병합되어 boilerplate 없이 다중 머신 구성을 재사용할 수 있다.

## 핵심 내용

Filip Ruman에 따르면 dendritic 패턴은 NixOS 설정의 모듈을 "뻗어나가는 나뭇가지" 구조로 조직한다 (출처: [[How to structure your NixOS config]]). 핵심은 세 가지:

- **Auto-import** — `import-tree` flake가 `modules/` 디렉토리 전체를 자동으로 읽어들인다. 파일/폴더 이름에 `_` prefix를 붙이면 제외. 새 모듈 추가 시 중앙 import 리스트 수정 불필요.
- **flake-parts 네임스페이스** — 모듈은 `flake.nixosModules.<name>` 또는 `flake.homeModules.<name>` 아래 선언. 같은 이름이 여러 파일에 존재하면 flake-file이 자동 병합.
- **호스트 디렉토리** — `modules/hosts/<host>/<host>.nix` 에 `nixosConfigurations.<host>`를 정의하고, 호스트별 `hw-config.nix`를 같은 폴더에 둔다. 재사용 모듈만 import하면 끝.

### 기본 구조

```
.
├── flake.nix
└── modules
    ├── audio.nix
    ├── fish.nix
    ├── nvidia.nix
    └── hosts
        └── desktop
            ├── desktop.nix
            └── hw-config.nix
```

### 모듈 조합

호스트 파일에서는 모듈 이름만 나열:

```nix
nixosConfigurations.desktop = inputs.nixpkgs.lib.nixosSystem {
  modules = with self.nixosModules; [
    desktop
    nvidia
    docker
    fish
  ];
};
```

### Flake-File로 외부 flake 주입

표준 패키지에 없는 프로그램(예: Zen Browser)은 어느 모듈에서든 `flake-file.inputs.<name>`으로 선언할 수 있다. 중앙 `flake.nix` 수정 없이 모듈 지역에서 의존성 선언 가능. 빌드 전 `sudo nix run .#write-flake`로 동기화.

### Home Manager 통합

`flake.homeModules.general` (모든 머신), `flake.homeModules.<host>` (머신별)로 나누어 선언. `home-manager.users.<user>.imports`에 이름으로 조합.

## NixOS 모듈 공유 패턴과의 관계

[[NixOS 모듈 공유 패턴]]은 공통 모듈 공유의 일반 아이디어. Dendritic 패턴은 그 아이디어의 **구체적 구현 방식** — auto-import + flake-parts 모듈 병합으로 공유 메커니즘 자체를 구조에 위임한다.

## 실전 사용

Filip Ruman은 `readHost`/`rebuild`/`updateNix` fish 함수로 단일 명령 업데이트 파이프라인을 구성한다. 호스트명은 `/etc/nixos/host.txt`에 저장하여 스크립트가 참조.

```fish
rebuild = "readHost ; cd /etc/nixos/NNC/ ; sudo nix run .#write-flake ; sudo nixos-rebuild switch --upgrade --flake .#$host"
updateNix = "cd /etc/nixos/NNC/; git pull ; rebuild ; sudo nix flake update ; onUpdate ; cleanup"
```

## 관련 링크

- [[NixOS 모듈 공유 패턴]] — 모듈 공유의 일반 원칙
- [[NixOS GitOps with Comin]] — dendritic 구조를 GitOps로 배포
- [[quadlet-nix]] — dendritic 모듈로 포함 가능한 컨테이너 정의 flake
- 레퍼런스 템플릿: `nix flake init -t github:vic/flake-file#dendritic`
- 예시 구성: https://github.com/FilipRuman/NNC, https://github.com/vimjoyer/nixconf
