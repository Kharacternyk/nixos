{ lib, flake-utils, host, nixpkgs, pkgs, ... }: {
  nix = {
    nixPath = [
      "nixpkgs=${nixpkgs}"
    ];
    registry = {
      flake-utils.to = {
        inherit (flake-utils) rev;
        owner = "numtide";
        repo = "flake-utils";
        type = "github";
      };
      nixpkgs.to = {
        inherit (nixpkgs) rev;
        owner = "NixOS";
        repo = "nixpkgs";
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
      flake-registry = [
        "/etc/nix/registry.json"
      ];
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
