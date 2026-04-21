---
publish: true
created: 2026-04-08T02:40:00Z
modified: 2026-04-08T02:40:00Z
tags:
  - kb
  - podman
  - quadlet
  - systemd
  - containers
---

Podman의 기능으로, 컨테이너를 systemd 서비스로 정의하여 개별 제어, 정확한 메트릭, 독립적 재시작을 가능하게 한다.

## 핵심 내용

Quadlet은 systemd 유닛 파일로 컨테이너를 선언적으로 정의한다. Docker Compose가 여러 컨테이너를 하나의 단위로 묶는 것과 달리, 각 컨테이너가 독립 systemd 서비스가 된다.

**Docker Compose의 문제 (Quadlet이 해결하는 것)**:

- 모든 컨테이너 로그가 하나로 합쳐짐
- CPU/메모리 메트릭이 cgroup 불일치로 부정확
- `systemctl`로 개별 컨테이너 제어 불가
- 재시작 시 전체 스택이 재시작

**Quadlet 유닛 파일 예시** (출처: [[Goodbye Docker, hello Quadlet]]):

```systemd
[Container]
Image=quay.io/fedora/fedora
Exec=sleep %i

[Service]
Restart=always

[Install]
WantedBy=multi-user.target
```

`depends_on`은 systemd 의존성으로 자연스럽게 처리된다.

## 실전 사용

NixOS에서는 [[quadlet-nix]]를 사용하여 Nix 표현식으로 Quadlet을 정의한다. `systemd.tmpfiles.rules`로 볼륨 마운트 디렉토리 생성을 보장할 수 있다.

**Grafana 메트릭**: 각 컨테이너가 독립 cgroup이므로 systemd 대시보드에서 정확한 리소스 사용량 확인 가능.

**주의점**: docker-compose.yaml → Nix/Quadlet 수동 변환 필요. Docker 전용 기능(swarm mode 등) 미지원.

## 관련 링크

- [[quadlet-nix]] — Nix 표현식 → Quadlet 변환 flake
- [[Nix 기반 Docker 이미지 빌드]] — 빌드 측면의 Nix 활용
- 관련 vault 노트: [[basic|Nix basic]]
- Podman 공식 문서: https://docs.podman.io/en/latest/markdown/podman-systemd.unit.5.html
