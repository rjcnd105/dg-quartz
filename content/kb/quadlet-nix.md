---
publish: true
created: 2026-04-08T02:40:00Z
modified: 2026-04-08T02:40:00Z
tags:
  - kb
  - nix
  - quadlet
  - podman
---

Nix 표현식을 [[Quadlet]] 파일로 변환하는 flake. NixOS에서 컨테이너를 선언적으로 정의할 때 사용.

## 핵심 내용

`quadlet-nix`는 `virtualisation.quadlet` 옵션으로 컨테이너, 네트워크, 볼륨, 포드를 Nix로 정의한다. systemd 유닛 파일을 직접 쓰지 않아도 됨 (출처: [[Goodbye Docker, hello Quadlet]]).

```nix
{ config, ... }: {
  virtualisation.quadlet = let
    inherit (config.virtualisation.quadlet) networks;
  in {
    containers.nginx = {
      containerConfig.image = "docker.io/library/nginx:latest";
      containerConfig.networks = [ "podman" networks.internal.ref ];
      serviceConfig.TimeoutStartSec = "60";
    };
    networks.internal.networkConfig.subnets = [ "10.0.123.1/24" ];
  };
}
```

**`oci-containers` 대비 장점**:

| | `quadlet-nix` | `oci-containers` | `arion` |
|---|---|---|---|
| 네트워크/포드 지원 | O | X | O |
| 변경 시 자동 업데이트/삭제 | O | - | X |
| rootless 컨테이너 | O | X | ? |
| podman-auto-update | O | O | X |

## 실전 사용

볼륨 마운트 디렉토리를 `systemd.tmpfiles.rules`로 보장하는 패턴:

```nix
systemd.tmpfiles.rules = [ "d /etc/stacks/esphome/config 0755 root root" ];
```

네트워크, 컨테이너, nginx 리버스 프록시를 하나의 Nix 파일에서 선언 가능.

## 관련 링크

- [[Quadlet]] — quadlet-nix가 생성하는 대상
- GitHub: https://github.com/SEIAROTg/quadlet-nix
- 실전 예시: https://github.com/Keyruu/shinyflakes/tree/main/hosts/highwind/stacks
