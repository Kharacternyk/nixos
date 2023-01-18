{
  outputs = inputs: {
    nixosConfigurations = {
      nixos-desktop = import ./hosts inputs "nixos-desktop" { };
      nixos-laptop-vm = import ./hosts inputs "nixos-laptop-vm" {
        gpu = false;
        usb = false;
      };
      nixos-vps = import ./hosts inputs "nixos-vps" {
        headless = true;
      };
      nixos-droplet = import ./hosts inputs "nixos-droplet" {
        headless = true;
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
}
