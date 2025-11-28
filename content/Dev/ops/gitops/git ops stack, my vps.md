---
{"publish":true,"created":"2025-10-29T04:54:07Z","modified":"2025-11-26T07:23:12Z","cssclasses":""}
---


### 리스트

#### kuber

심플, 경량: k3s
k8s
보안이 아주 중요한 경우: RKE2
쿠버네티스 기반 OS: Talos os -

#### kuber cloud

1. EKS (Amazon)
2. AKS (ms)

#### CLI

1. [k9s](https://github.com/derailed/k9s)
2. kubectl

#### CI

1. github action

#### telemetry

소
1. netdata, local journald

중대
1. Grafana/Prometheus

#### CD

1. fluxCD
2. argoCD(gui)

#### Override

kustomize: kuber yaml 설정 변수 기반으로 덮어 씌우기. 버전을 올리는 경우 등에 사용

#### db

1. [stackgres](https://stackgres.io/) (postgresql)

#### security

1. cilium

#### dashboard

[kite](https://github.com/zxh326/kite)

#### config lang

default yaml

1. cue
2. pkl
3. nickel

#### Package Manager

1. Helm

alpha
1. [yoke](https://yokecd.github.io/docs/concepts/cluster-access/)

#### Data Layer

redis 포지션

1. Garnet

#### Gateway Layer

ngnix 포지션

1. Caddy
2. Nginx Proxy manager (NPM)
3. Traefik (간단한 경우)

#### Messaging System

1. NATS(with Jetstream)
2. 

#### data storage

small
1. minio block storage

#### else

쿠버 PostgreSQL 솔루션: [cloudenative-PG](https://github.com/cloudnative-pg/cloudnative-pg)

#####  alpha

https://github.com/kubernetes-sigs/kro

gitops podman quadlet
https://github.com/stryan/materia

with nix
https://github.com/Lillecarl/easykubenix
https://github.com/Lillecarl/nix-csi

1. [crossplane](https://www.crossplane.io/)

#### 관련 글

[Kubernetes 오케스트레이션은 YAML 파일 그 이상입니다.](https://yokecd.github.io/blog/posts/yoke-resource-orchestration/)
[공식 쿠버네티스 모범 사례](https://kubernetes.io/blog/2025/11/25/configuration-good-practices/)

---

### 내 VPS 용 Stack

mise
k3s
helm
fluxCD
kite

일단
한번 설정하고 말 것이라면 ansible 까지는 과한 듯 -> 방화벽은 수동으로 하고 mise를 사용
