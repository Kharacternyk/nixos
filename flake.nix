{
  outputs = { self, nixpkgs }: {
    nixosConfigurations.nixos-desktop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./machines/nixos-desktop/configuration.nix
        ./common
        ./optional/xserver
        ./optional/texlive
      ];
    };
  };
}
