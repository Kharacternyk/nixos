{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations = {
      nixos-desktop = import ./hosts nixpkgs "nixos-desktop" { };
      nixos-laptop-vm = import ./hosts nixpkgs "nixos-laptop-vm" {
        hardwareAcceleration = false;
      };
    };
  };
}
