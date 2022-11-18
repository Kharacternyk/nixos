inputs: host: opts:
let
  system = opts.system or "x86_64-linux";
  headless = opts.headless or false;
in
inputs.nixpkgs.lib.nixosSystem {
  inherit system;
  modules = import ../modules ++ [
    (./. + "/${host}/configuration.nix")
  ];
  specialArgs = {
    inherit system headless inputs;
    hostname = host;
    usb = !headless;
    gpu = !headless;
    dev = !headless;
  } // opts;
}
