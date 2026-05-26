---
publish: true
created: 2024-12-27T06:43:33Z
modified: 2025-10-16T04:48:55Z
---

기본적인 쉘 스크립트 실행

```nix
{ pkgs, ... }: {
t = builtins.readFile (
	pkgs.runCommand  "timestamp" { when = builtins.currentTime; } "echo -n `date -d @$when +%Y-%m-%d_%H-%M-%S` > $out"
)
```

폴더링으로 할 수 있다.

```nix
pkgs.runCommandLocal "ex-dir" {} "
```
