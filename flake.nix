{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    bspwm-utils = {
      url = "github:Kharacternyk/bspwm-utils";
      flake = false;
    };
    qutelaunch = {
      url = "github:Kharacternyk/qutelaunch";
      flake = false;
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
  };

  outputs = inputs: {
    nixosConfigurations = {
      nixos-desktop = import ./hosts inputs "nixos-desktop" { };
      nixos-laptop-vm = import ./hosts inputs "nixos-laptop-vm" {
        hardwareAcceleration = false;
      };
    };
  };
}
