host: host.inputs.nixpkgs.lib.nixosSystem {
  inherit (host) system;
  modules = import ../modules ++ [
    ./${host.name}
  ];
  specialArgs = {
    inherit host;
    functions = import ../functions.nix;
  };
}
