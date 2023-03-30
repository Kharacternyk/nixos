{ pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];
  services.xserver.displayManager.setupCommands = ''
    ${pkgs.xorg.setxkbmap}/bin/setxkbmap
    ${pkgs.xorg.xset}/bin/xset -dpms
  '';
  services.xserver.xrandrHeads = [
    { output = "DVI-I-1"; primary = true; }
  ];
  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/sda";
  };
  system.stateVersion = "20.09";
}
