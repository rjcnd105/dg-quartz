---
{"publish":true,"created":"2025-11-18T07:01:27Z","modified":"2025-11-19T03:28:47Z","cssclasses":""}
---


docker compose 실행시 enc 파일 및 `MISE_SOPS_AGE_KEY` 를 주입하여 실행한다.
`MISE_SOPS_AGE_RECIPIENTS` 는 .sops.yaml에 등록된 age의 public key 이다. env를 통해 넘겨준다.

env 파일이 이미지에 남지 않도록 시크릿으로 전달합니다.

### docker compose

```yaml
name: with-enc
services:
	sync:
		build:
			context: .
			dockerfile: ci.dockerfile

		secrets:
			- source: s1
				target: /run/secrets/s1
			- source: s2
				target: /run/secrets/s2
		
		environment:
			MISE_SOPS_AGE_KEY: ${MISE_SOPS_AGE_KEY?required}
			MISE_SOPS_AGE_RECIPIENTS: "ci-age-public-key"

		volumes:
			- ./sync:/with-enc/sync:ro

secrets:
	s1:
		file: ./s1.enc.yaml
	s2:
		file: ./s2.enc.yaml
```

### dockerfile

```dockerfile
FROM alpine:3.22 AS base

WORKDIR /with-enc

ENV MISE_DATA_DIR="/mise" \
	MISE_CONFIG_DIR="/mise" \
	MISE_CACHE_DIR="/mise/cache" \
	MISE_INSTALL_PATH="/usr/local/bin/mise" \
	PATH="/mise/shims:$PATH" \
	MISE_OVERRIDE_CONFIG_FILENAMES="mise.tools.toml,mise.tasks.toml"


RUN apk add --no-cache ca-certificates rsync curl openssh-client \
	&& rm -rf /var/cache/apk/* \
	&& curl -fsSL https://mise.run | sh

RUN ln -s /run/secrets/s1 ./s1.enc.yaml || true
RUN ln -s /run/secrets/s2 ./s2.enc.yaml || true

COPY mise.tools.toml .

RUN mise install

FROM base AS tasks

COPY mise.tasks.toml .
RUN mise trust

CMD ["sh", "-c", "mise run my-task"]
```

### mise.tools.toml

```toml
[tools.sops]
version = "3.11.0"


[tools.age]
version = "1.2.1"


[env]
SOPS_AGE_KEY = { value = "{{env.MISE_SOPS_AGE_KEY}}", redact = true, read_only = true }

```

### mise.tasks.toml

mise의 태스크로 실행시 env에 있는 암호화된 시크릿이 주입되어 있는 격리된 환경에서 실행됩니다.

```toml
[tools.my-task]
run = '''
	echo "$MY_SECRET_1"
	echo "$MY_SECRET_2"
'''

[env]
_.file = [
	{ path = "./s1.enc.yaml", redact = true, read_only = true },
	{ path = "./s2.enc.yaml", redact = true, read_only = true }
]
```
