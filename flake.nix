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
    nixpkgs.url = "github:flox/nixpkgs/unstable";
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
      url = "github:Kharacternyk/vim-suda";
      flake = false;
    };
    vim-typst = {
      url = "github:kaarmu/typst.vim";
      flake = false;
    };
  };
}
