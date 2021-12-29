{ nixpkgs, pkgs, ... }: {
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    registry.nixpkgs.flake = nixpkgs;
    nixPath = [ ];
  };
  nixpkgs.config.allowUnfree = true;
}
