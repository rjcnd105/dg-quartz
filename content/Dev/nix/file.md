---
{"publish":true,"created":"2024.12.27 금 오후 15:43","modified":"2025.08.29 금 오후 18:26","published":"2025-10-13T14:07:27.044+09:00","cssclasses":"","createdAt":"2024.12.27 금 오후 15:43","modifiedAt":"2025.08.29 금 오후 18:26"}
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
