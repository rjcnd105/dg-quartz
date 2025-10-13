---
{"publish":true,"created":"2024-12-27T15:43:33.384+09:00","modified":"2025-10-13T12:57:16.755+09:00","cssclasses":""}
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

