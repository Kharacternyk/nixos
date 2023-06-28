host: host.inputs.nixpkgs.lib.nixosSystem {
  inherit (host) system;
  modules = import ../modules ++ [
    ./${host.name}/configuration.nix
  ];
  specialArgs = {
    inherit host;
  };
}
