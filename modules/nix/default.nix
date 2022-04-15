{ nixpkgs, pkgs, ... }: {
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
    registry.nixpkgs.flake = nixpkgs;
    nixPath = [
      "nixpkgs=${nixpkgs}"
    ];
  };
  nixpkgs.config.allowUnfree = true;
}
