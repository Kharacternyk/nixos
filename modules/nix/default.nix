{ inputs, pkgs, ... }: {
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
      flake-registry = /etc/nixos/registry.json
      warn-dirty = false
    '';
    registry.nixpkgs.flake = inputs.nixpkgs;
    nixPath = [
      "nixpkgs=${inputs.nixpkgs}"
    ];
  };
  nixpkgs.config.allowUnfree = true;
}
