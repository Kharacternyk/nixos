{ inputs, ... }: {
  imports = [
    "${inputs.nixpkgs}/nixos/modules/virtualisation/openstack-config.nix"
  ];
  system.stateVersion = "22.05";
}
