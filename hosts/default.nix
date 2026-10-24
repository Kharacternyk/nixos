host:
let inherit (host.inputs.nixpkgs) lib; in lib.nixosSystem {
  modules = import ../modules lib ++ [
    ./${host.name}
  ];
  specialArgs = {
    inherit host;
    keys = import ../keys lib;
  } // host.inputs;
  system = host.inputs.flake-utils.lib.system.x86_64-linux;
}
