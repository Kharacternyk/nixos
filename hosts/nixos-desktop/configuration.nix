{ pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];
  networking.interfaces.wlp2s0u1u4.useDHCP = false;
  services.xserver = {
    xrandrHeads = [
      {
        output = "HDMI-0";
        monitorConfig = ''
          Option "PreferredMode" "1360x768"
        '';
      }
      {
        output = "DVI-0";
        primary = true;
        monitorConfig = ''
          Option "PreferredMode" "1920x1200"
        '';
      }
    ];
    displayManager.setupCommands = ''
      ${pkgs.xorg.setxkbmap}/bin/setxkbmap
      ${pkgs.xorg.xset}/bin/xset -dpms
    '';
  };
  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/sda";
  };
  system.stateVersion = "20.09";
}
