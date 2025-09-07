{ lib, host, pkgs, ... }: {
  nix = {
    nixPath = [
      "nixpkgs=${host.inputs.nixpkgs}"
    ];
    registry = {
      flake-utils.to = {
        owner = "numtide";
        repo = "flake-utils";
        rev = host.inputs.flake-utils.rev;
        type = "github";
      };
      nixpkgs.to = {
        owner = "NixOS";
        repo = "nixpkgs";
        rev = host.inputs.nixpkgs.rev;
        type = "github";
      };
    } // lib.attrsets.mapAttrs'
      (name: value: { name = "${name}-local"; value.flake = value; })
      host.inputs;
    settings = {
      experimental-features = [
        "flakes"
        "nix-command"
      ];
      flake-registry = [ ];
      warn-dirty = false;
    } // lib.optionalAttrs (host ? hasCuda) {
      extra-substituters = [
        "https://nix-community.cachix.org"
      ];
      extra-trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };
  nixpkgs.config.allowUnfree = true;
}
