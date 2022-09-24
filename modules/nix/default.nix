{ inputs, pkgs, ... }: {
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
      flake-registry = /etc/nixos/registry.json
      warn-dirty = false
    '';
    nixPath = [
      "nixpkgs=${inputs.nixpkgs}"
    ];
    registry = {
      nixpkgs.to = {
        owner = "NixOS";
        repo = "nixpkgs";
        rev = inputs.nixpkgs.rev;
        type = "github";
      };
      shellpkgs.flake = inputs.nixpkgs;
    };
  };
  nixpkgs.config.allowUnfree = true;
}
