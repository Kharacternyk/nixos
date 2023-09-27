{ host, pkgs, ... }: {
  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
      flake-registry =
      warn-dirty = false
    '';
    nixPath = [
      "nixpkgs=${host.inputs.nixpkgs}"
    ];
    package = pkgs.nixFlakes;
    registry = {
      flake-utils.to = {
        owner = "numtide";
        repo = "flake-utils";
        rev = host.inputs.flake-utils.rev;
        type = "github";
      };
      flake-utils-local.flake = host.inputs.flake-utils;
      nixpkgs.to = {
        owner = "NixOS";
        repo = "nixpkgs";
        rev = host.inputs.nixpkgs.rev;
        type = "github";
      };
      nixpkgs-local.flake = host.inputs.nixpkgs;
    };
  };
  nixpkgs.config.allowUnfree = true;
}
