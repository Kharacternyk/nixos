host: host.inputs.nixpkgs.lib.nixosSystem {
  inherit (host) system;
  modules = import ../modules ++ [
    ./${host.name}/configuration.nix
  ];
  specialArgs = {
    inherit host;
    readAttributes = file: set:
      builtins.map (attribute: set.${attribute}) (
        builtins.filter (attribute: builtins.isString attribute && attribute != "") (
          builtins.split "\n" (
            builtins.readFile file
          )
        )
      );
  };
}
