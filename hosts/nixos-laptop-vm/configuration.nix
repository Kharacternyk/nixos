{ pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];
  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/sda";
  };
  system.stateVersion = "20.09";
}
