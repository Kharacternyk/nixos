{ lib, host, pkgs, ... }: {
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
      nixpkgs.to = {
        owner = "NixOS";
        repo = "nixpkgs";
        rev = host.inputs.nixpkgs.rev;
        type = "github";
      };
    } // lib.attrsets.mapAttrs'
      (name: value: { name = "${name}-local"; value.flake = value; })
      host.inputs;
  };
  nixpkgs.config.allowUnfree = true;
}
