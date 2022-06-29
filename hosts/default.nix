inputs: hostname: opts: inputs.nixpkgs.lib.nixosSystem {
  system = opts.system or "x86_64-linux";
  modules = import ../modules ++ [
    (./. + "/${hostname}/configuration.nix")
  ];
  specialArgs = {
    hostname = hostname;
    inputs = inputs;
    headless = false;
    hardwareAcceleration = true;
    dev = true;
  } // opts;
}
