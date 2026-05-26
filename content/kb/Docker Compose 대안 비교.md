---
publish: true
created: 2026-04-08T02:47:00Z
modified: 2026-04-08T02:47:00Z
tags:
  - kb
  - docker
  - podman
  - nix
  - containers
---

NixOS에서 Docker Compose를 대체하는 도구들의 비교. 각각의 트레이드오프.

## 핵심 내용

Docker Compose를 systemd 서비스로 감싸면 로그 통합, 메트릭 부정확, 개별 제어 불가 문제가 발생 (출처: [[Goodbye Docker, hello Quadlet]]).

**비교표**:

| | [[quadlet-nix]] | `oci-containers` | `arion` | Docker Compose on systemd |
|---|---|---|---|---|
| 개별 컨테이너 systemctl 제어 | O | O | O | X |
| 네트워크/포드 지원 | O | X | O | O |
| 변경 시 네트워크 자동 갱신 | O | - | X | - |
| rootless 컨테이너 | O | X | ? | X |
| podman-auto-update | O | O | X | X |
| 정확한 cgroup 메트릭 | O | O | O | X |
| Nix 선언적 정의 | O | O | O | 부분적 |

**선택 기준**:

- 풀 Nix 선언적 + 개별 제어 필요 → [[quadlet-nix]]
- 간단한 단일 컨테이너 → `oci-containers`로 충분
- Docker Compose yaml 호환 필요 → `arion`
- 풀 오케스트레이션 → [[NixOS GitOps with Comin|Kubernetes]]

## 관련 링크

- [[Quadlet]] — quadlet-nix가 생성하는 대상의 상세
- [[quadlet-nix]] — Nix로 Quadlet 정의하는 도구
