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
  } // opts // (if (opts.dev or true) == false then {
    dev = { };
  } else {
    dev = {
      python = true;
      js = true;
      flutter = true;
      android = true;
      latex = true;
      r = true;
      pandoc = true;
    } // (opts.dev or { });
  });
}
