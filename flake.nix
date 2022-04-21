{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs: {
    nixosConfigurations = {
      nixos-desktop = import ./hosts inputs "nixos-desktop" { };
      nixos-laptop-vm = import ./hosts inputs "nixos-laptop-vm" {
        hardwareAcceleration = false;
      };
    };
  };
}
