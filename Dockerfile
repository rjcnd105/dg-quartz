FROM oven/bun:1.3.14-slim AS builder
WORKDIR /usr/src/app
COPY package.json .
COPY bun.lock .
COPY quartz/ ./quartz/
COPY quartz.config.yaml .
COPY quartz.lock.json .
RUN bun install --frozen-lockfile && bun --bun quartz plugin install

FROM oven/bun:1.3.14-slim
WORKDIR /usr/src/app
COPY --from=builder /usr/src/app/ /usr/src/app/
COPY . .
CMD ["bun", "--bun", "quartz", "build", "--serve", "--baseDir", "dg-quartz"]
