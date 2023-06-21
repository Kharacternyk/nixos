{
  imports = [
    ./hardware-configuration.nix
  ];
  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
  };
  system.stateVersion = "20.09";
}
