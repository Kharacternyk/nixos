host: host.inputs.nixpkgs.lib.nixosSystem {
  system = host.system or "x86_64-linux";
  modules = import ../modules ++ [
    ./${host.name}/configuration.nix
  ];
  specialArgs = {
    inherit host;
  };
}
