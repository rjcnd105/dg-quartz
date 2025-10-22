---
{"publish":true,"created":"2025-10-06T11:24:55Z","modified":"2025-10-22T01:43:08Z","tags":["sops","sops-nix","nix","nix_flake","age","gitops"],"cssclasses":""}
---


저장소
https://github.com/Mic92/sops-nix

이 글에서 설명이 잘 되어 있다.
https://michael.stapelberg.ch/posts/2025-08-24-secret-management-with-sops-nix/

위 글을 기반으로 설정하면서
mac이라면 nix-darwin을 사용해서 저장소에 있는 darwin guide를 따르면 된다.
```nix
{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.nix-darwin.url = "github:nix-darwin/nix-darwin/master";
  inputs.nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  inputs.sops-nix.url = "github:Mic92/sops-nix";
  #inputs.sops-nix.inputs.nixpkgs.follows = "nixpkgs";

  outputs = { self, nix-darwin, nixpkgs, sops-nix }: {
    darwinConfigurations.yourhostname = nix-darwin.lib.darwinSystem {
      modules = [
        ./configuration.nix
        sops-nix.darwinModules.sops
      ];
    };
  };
}
```

home manager라면
```nix
{
	home-manager = {
		sharedModules = [
			inputs.sops-nix.homeManagerModules.sops
		];
	};
	# ...
}
```

현재 내 flake내 sops 설정 파일
https://github.com/rjcnd105/hj-dotfiles/blob/main/homes/workspace/sops.nix
