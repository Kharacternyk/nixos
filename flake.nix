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
    bspwm-utils = {
      url = "github:Kharacternyk/bspwm-utils";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
    flake-utils.url = "github:numtide/flake-utils";
    klunok = {
      url = "github:Kharacternyk/klunok";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
    nixpkgs.url = "github:flox/nixpkgs/unstable";
    qutebrowser-mypy = {
      url = "https://raw.githubusercontent.com/qutebrowser/qutebrowser/refs/heads/main/.mypy.ini";
      flake = false;
    };
    qutebrowser-patch = {
      url = "https://patch-diff.githubusercontent.com/raw/qutebrowser/qutebrowser/pull/8642.patch";
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
