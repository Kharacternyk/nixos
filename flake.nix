{
  outputs = inputs: {
    nixosConfigurations = {
      nixos-desktop = import ./hosts {
        inherit inputs;
        name = "nixos-desktop";
        system = inputs.flake-utils.lib.system.x86_64-linux;
        hasGpu = true;
        hasScreen = true;
        hasWifi = true;
        hasBackup = true;
      };
      nixos-server = import ./hosts {
        inherit inputs;
        name = "nixos-server";
        system = inputs.flake-utils.lib.system.x86_64-linux;
        hasCuda = true;
      };
    };
  };

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    klunok = {
      url = "github:Kharacternyk/klunok";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
    bspwm-utils = {
      url = "github:Kharacternyk/bspwm-utils";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
    vim-bullets = {
      url = "github:dkarter/bullets.vim";
      flake = false;
    };
    vim-gruvbox = {
      url = "github:gruvbox-community/gruvbox";
      flake = false;
    };
    vim-suda = {
      url = "github:lambdalisue/suda.vim";
      flake = false;
    };
    vim-typst = {
      url = "github:kaarmu/typst.vim";
      flake = false;
    };
  };
}
