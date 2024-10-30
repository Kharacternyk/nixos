{ host, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader.grub = {
      enable = true;
      device = "/dev/sda";
    };
  };
  environment.systemPackages = [
    pkgs.alsa-scarlett-gui
  ];
  services.xserver = {
    displayManager.setupCommands = ''
      ${pkgs.xorg.setxkbmap}/bin/setxkbmap
      ${pkgs.xorg.xset}/bin/xset -dpms
    '';
    xkb.options = "ctrl:swap_rwin_rctl";
    xrandrHeads = [
      {
        output = "HDMI-1";
        monitorConfig = ''
          Option "Rotate" "left"
        '';
      }
      {
        output = "DVI-D-1";
        primary = true;
      }
      {
        output = "HDMI-2";
        monitorConfig = ''
          Option "RightOf" "DVI-D-1"
        '';
      }
    ];
  };
  system.stateVersion = "20.09";
}
