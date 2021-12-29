{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations = {
      nixos-desktop = import ./hosts nixpkgs "nixos-desktop" { };
    };
  };
}
