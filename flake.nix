{
  outputs = inputs: {
    nixosConfigurations = {
      nixos-desktop = import ./hosts {
        inherit inputs;
        name = "nixos-desktop";
        system = inputs.flake-utils.lib.system.x86_64-linux;
        hasEnoughStorage = true;
        hasGpu = true;
        hasScreen = true;
        hasWifi = true;
        isForDevelopment = true;
      };
      nixos-laptop-vm = import ./hosts {
        inherit inputs;
        name = "nixos-laptop-vm";
        system = inputs.flake-utils.lib.system.x86_64-linux;
        hasEnoughRam = true;
        hasScreen = true;
        isForDevelopment = true;
      };
    };
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
