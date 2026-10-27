{
  flake-utils,
  host,
  lib,
  nixpkgs,
  ...
}:
{
  nix = {
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
    }
    // lib.mapAttrs' (name: value: {
      name = "${name}-local";
      value.flake = value;
    }) host.inputs;
    settings = {
      experimental-features = [
        "flakes"
        "nix-command"
      ];
      flake-registry = [
        "/etc/nix/registry.json"
      ];
      nix-path = [
        "nixpkgs=${nixpkgs}"
      ];
      warn-dirty = false;
    }
    // lib.optionalAttrs (host ? hasCuda) {
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
