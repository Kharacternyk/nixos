{ host, pkgs, ... }: {
  imports = let hardware = host.inputs.nixos-hardware.nixosModules; in [
    ./hardware-configuration.nix
    hardware.common-gpu-amd-southern-islands
  ];
  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
  };
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
        output = "DVI-I-1";
        primary = true;
      }
    ];
  };
  system.stateVersion = "20.09";
}
