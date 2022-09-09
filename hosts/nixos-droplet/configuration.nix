{ modulesPath, ... }: {
  imports = [
    (modulesPath + "/virtualisation/digital-ocean-config.nix")
  ];
  system.stateVersion = "20.09";
}
