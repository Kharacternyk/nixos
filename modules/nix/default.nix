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
      flake-registry = [
        "/etc/nix/registry.json"
      ];
      warn-dirty = false;
    } // lib.optionalAttrs (host ? hasCuda) {
      extra-substituters = [
        "https://cache.flox.dev"
      ];
      extra-trusted-public-keys = [
        "flox-cache-public-1:7F4OyH7ZCnFhcze3fJdfyXYLQw/aV7GEed86nQ7IsOs="
      ];
    };
  };
  nixpkgs.config.allowUnfree = true;
}
