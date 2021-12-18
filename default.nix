nixpkgs:
hostname:
{ headless ? false
,
}:
let
  commonModules = [
    ./common
    {
      nix.registry.nixpkgs.flake = nixpkgs;
    }
  ];
  extraModules = if headless then [ ] else [
    ./optional/xserver
    ./optional/texlive
  ];
  machineModule = ./machines + "/${hostname}/configuration.nix";
in
commonModules ++ extraModules ++ [ machineModule ]
