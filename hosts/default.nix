host:
let inherit (host.inputs.nixpkgs) lib; in lib.nixosSystem {
  inherit (host) system;
  modules = import ../modules lib ++ [
    ./${host.name}
  ];
  specialArgs = {
    inherit host;
    keys = import ../keys lib;
  } // host.inputs;
}
