{ inputs, system, ... }: {
  nix = {
    package = inputs.nix-lazy-trees.packages.${system}.nix;
    extraOptions = ''
      experimental-features = nix-command flakes
      flake-registry = /etc/nixos/registry.json
      warn-dirty = false
    '';
    nixPath = [
      "nixpkgs=${inputs.nixpkgs}"
    ];
    registry = {
      nixpkgs-local.flake = inputs.nixpkgs;
      nixpkgs.to = {
        owner = "NixOS";
        repo = "nixpkgs";
        rev = inputs.nixpkgs.rev;
        type = "github";
      };
      flake-utils-local.flake = inputs.flake-utils;
      flake-utils.to = {
        owner = "numtide";
        repo = "flake-utils";
        rev = inputs.flake-utils.rev;
        type = "github";
      };
    };
  };
  nixpkgs.config.allowUnfree = true;
}
