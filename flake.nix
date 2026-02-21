{
  outputs = inputs: {
    nixosConfigurations = {
      nixos-desktop = import ./hosts {
        inherit inputs;
        name = "nixos-desktop";
        system = inputs.flake-utils.lib.system.x86_64-linux;
        klunokSuffix = "";
        hasGpu = true;
        hasScreen = true;
        hasWifi = true;
        hasBackup = true;
      };
      nixos-server = import ./hosts {
        inherit inputs;
        name = "nixos-server";
        system = inputs.flake-utils.lib.system.x86_64-linux;
        klunokSuffix = "s";
        hasCuda = true;
      };
      nixos-laptop-vm = import ./hosts {
        inherit inputs;
        name = "nixos-laptop-vm";
        system = inputs.flake-utils.lib.system.x86_64-linux;
        klunokSuffix = "lvm";
        hasScreen = true;
        usesDantooine = true;
      };
    };
  };

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    bspwm-utils = {
      url = "github:Kharacternyk/bspwm-utils";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
    klunok = {
      url = "github:Kharacternyk/klunok";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
    modal = {
      url = "github:modal-labs/modal-client";
      flake = false;
    };
    nixpkgs.url = "github:flox/nixpkgs/unstable";
    setuptools-77 = {
      url = "github:pypa/setuptools/v77.0.3";
      flake = false;
    };
    synchronicity = {
      url = "github:modal-labs/synchronicity";
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
      url = "github:Kharacternyk/vim-suda";
      flake = false;
    };
    vim-typst = {
      url = "github:kaarmu/typst.vim";
      flake = false;
    };
  };
}
