inputs: host: opts: inputs.nixpkgs.lib.nixosSystem {
  system = opts.system or "x86_64-linux";
  modules = import ../modules ++ [
    (./. + "/${host}/configuration.nix")
  ];
  specialArgs = let headless = opts.headless or false; in {
    hostname = host;
    inputs = inputs;
    headless = headless;
    usb = !headless;
    gpu = !headless;
    dev = !headless;
  } // opts;
}
