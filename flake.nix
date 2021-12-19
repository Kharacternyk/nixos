{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations = {
      nixos-desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = import ./modules nixpkgs "nixos-desktop" { };
      };
    };
  };
}
