{
  outputs = inputs: {
    nixosConfigurations = {
      nixos-desktop = import ./hosts {
        inherit inputs;
        hasBackup = true;
        hasGpu = true;
        hasScreen = true;
        hasWifi = true;
        klunokSuffix = "";
        name = "nixos-desktop";
        primaryKey = "Hoth";
      };
      nixos-laptop-vm = import ./hosts {
        inherit inputs;
        hasScreen = true;
        klunokSuffix = "lvm";
        name = "nixos-laptop-vm";
        primaryKey = "Dantooine";
      };
      nixos-server = import ./hosts {
        inherit inputs;
        klunokSuffix = "s";
        lacksSensibility = true;
        name = "nixos-server";
      };
    };
  };
  inputs = {
    bspwm-utils = {
      inputs = {
        flake-utils.follows = "flake-utils";
        nixpkgs.follows = "nixpkgs";
      };
      url = "github:Kharacternyk/bspwm-utils";
    };
    flake-utils.url = "github:numtide/flake-utils";
    fretwire = {
      inputs = {
        flake-utils.follows = "flake-utils";
        nixpkgs.follows = "nixpkgs";
      };
      url = "github:Kharacternyk/fretwire";
    };
    ibm-plex = {
      flake = false;
      url = "https://github.com/IBM/plex/releases/download/v6.4.0/TrueType.zip";
    };
    klunok = {
      inputs = {
        flake-utils.follows = "flake-utils";
        nixpkgs.follows = "nixpkgs";
      };
      url = "github:Kharacternyk/klunok";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    ocenaudio = {
      flake = false;
      url = "file+https://www.ocenaudio.com/downloads/index.php/ocenaudio_debian12.deb";
    };
    vim-conform = {
      flake = false;
      url = "github:stevearc/conform.nvim";
    };
    vim-gruvbox = {
      flake = false;
      url = "github:gruvbox-community/gruvbox";
    };
    vim-typst = {
      flake = false;
      url = "github:kaarmu/typst.vim";
    };
  };
}
