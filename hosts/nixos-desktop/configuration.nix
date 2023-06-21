{ pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];
  services.xserver = {
    displayManager.setupCommands = ''
      ${pkgs.xorg.setxkbmap}/bin/setxkbmap
      ${pkgs.xorg.xset}/bin/xset -dpms
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
