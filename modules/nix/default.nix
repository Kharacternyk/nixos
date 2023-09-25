{ host, pkgs, ... }: {
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
      warn-dirty = false
      flake-registry =
    '';
    nixPath = [
      "nixpkgs=${host.inputs.nixpkgs}"
    ];
    registry = {
      nixpkgs-local.flake = host.inputs.nixpkgs;
      nixpkgs.to = {
        owner = "NixOS";
        repo = "nixpkgs";
        rev = host.inputs.nixpkgs.rev;
        type = "github";
      };
      flake-utils-local.flake = host.inputs.flake-utils;
      flake-utils.to = {
        owner = "numtide";
        repo = "flake-utils";
        rev = host.inputs.flake-utils.rev;
        type = "github";
      };
    };
  };
  nixpkgs.config.allowUnfree = true;
}
