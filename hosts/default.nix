inputs: host: opts: inputs.nixpkgs.lib.nixosSystem {
  system = opts.system or "x86_64-linux";
  modules = import ../modules ++ [
    (./. + "/${host}/configuration.nix")
  ];
  specialArgs = {
    hostname = host;
    inputs = inputs;
    headless = false;
    usb = !opts.headless or true;
    gpu = !opts.headless or true;
    dev = !opts.headless or true;
    univ = !opts.headless or true;
  } // opts;
}
