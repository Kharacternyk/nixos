{ pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];
  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
  };
  environment.variables.QT_XCB_FORCE_SOFTWARE_OPENGL = "1";
  services.xserver = {
    displayManager.setupCommands = ''
      ${pkgs.xorg.setxkbmap}/bin/setxkbmap
      ${pkgs.xorg.xset}/bin/xset -dpms
    '';
    xkbOptions = "ctrl:swap_rwin_rctl";
    xrandrHeads = [
      {
        output = "DVI-I-1";
        primary = true;
      }
    ];
  };
  system.stateVersion = "20.09";
}
