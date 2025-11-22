---
{"publish":true,"created":"2025-10-29T04:54:07Z","modified":"2025-11-21T05:33:13Z","cssclasses":""}
---


### 리스트

#### kuber

심플, 경량: k3s
k8s
보안이 아주 중요한 경우: RKE2

#### kuber cloud

1. EKS (Amazon)
2. AKS (ms)

#### CLI

1. [k9s](https://github.com/derailed/k9s)
2. kubectl

#### CI

1. github action

#### CD

1. fluxCD
2. argoCD(gui)

#### Override

kustomize: kuber yaml 설정 변수 기반으로 덮어 씌우기. 버전을 올리는 경우 등에 사용

#### dashboard

[kite](https://github.com/zxh326/kite)

#### config lang

alpha
1. [nickel](https://nickel-lang.org/)

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

#### Messaging System

1. NATS(with Jetstream)
2. 

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

---

### 내 VPS 용 Stack

mise
k3s
helm
fluxCD
kite

일단
한번 설정하고 말 것이라면 ansible 까지는 과한 듯 -> 방화벽은 수동으로 하고 mise를 사용
