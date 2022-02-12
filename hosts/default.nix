nixpkgs: hostname: opts: nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  modules = import ../modules ++ [
    (./. + "/${hostname}/configuration.nix")
  ];
  specialArgs = {
    hostname = hostname;
    nixpkgs = nixpkgs;
    headless = false;
    hardwareAcceleration = true;
  } // opts;
}
