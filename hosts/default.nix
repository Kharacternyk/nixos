host:
let
  inherit (host.inputs.nixpkgs) lib;
  system = host.inputs.flake-utils.lib.system.x86_64-linux;
in
lib.nixosSystem {
  inherit system;
  modules = import ../modules lib ++ [
    ./${host.name}
  ];
  specialArgs = {
    inherit host system;
    keys = import ../keys lib;
  } // host.inputs;
}
