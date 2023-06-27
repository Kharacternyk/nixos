{ lib, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];
  services.xserver = {
    displayManager.setupCommands = ''
      ${lib.getExe pkgs.xorg.setxkbmap}
      ${lib.getExe pkgs.xorg.xset} -dpms
    '';
    xrandrHeads = [
      { output = "DVI-I-1"; primary = true; }
    ];
    xkbOptions = "ctrl:swap_rwin_rctl";
  };
  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
  };
  system.stateVersion = "20.09";
}
