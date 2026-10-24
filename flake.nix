{
  outputs = inputs: {
    nixosConfigurations = {
      nixos-desktop = import ./hosts {
        inherit inputs;
        name = "nixos-desktop";
        primaryKey = "Hoth";
        system = inputs.flake-utils.lib.system.x86_64-linux;
        klunokSuffix = "";
        hasBackup = true;
        hasGpu = true;
        hasScreen = true;
        hasWifi = true;
      };
      nixos-server = import ./hosts {
        inherit inputs;
        name = "nixos-server";
        system = inputs.flake-utils.lib.system.x86_64-linux;
        klunokSuffix = "s";
        lacksSensibility = true;
      };
      nixos-laptop-vm = import ./hosts {
        inherit inputs;
        name = "nixos-laptop-vm";
        primaryKey = "Dantooine";
        system = inputs.flake-utils.lib.system.x86_64-linux;
        klunokSuffix = "lvm";
        hasScreen = true;
      };
    };
  };

  inputs = {
    bspwm-utils = {
      url = "github:Kharacternyk/bspwm-utils";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
    flake-utils.url = "github:numtide/flake-utils";
    fretwire = {
      url = "github:Kharacternyk/fretwire";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
    klunok = {
      url = "github:Kharacternyk/klunok";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    vim-conform = {
      url = "github:stevearc/conform.nvim";
      flake = false;
    };
    vim-gruvbox = {
      url = "github:gruvbox-community/gruvbox";
      flake = false;
    };
    vim-typst = {
      url = "github:kaarmu/typst.vim";
      flake = false;
    };
  };
}
