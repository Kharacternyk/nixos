{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let inherit-nixpkgs = {
      nix.registry.nixpkgs.flake = nixpkgs;
    }; in
    {
      nixosConfigurations = {
        nixos-desktop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./machines/nixos-desktop/configuration.nix
            ./common
            ./optional/xserver
            ./optional/texlive
            inherit-nixpkgs
          ];
        };
      };
    };
}
