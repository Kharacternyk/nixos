{
  fretwire,
  lib,
  pkgs,
  ...
}:
{
  boot = {
    initrd.availableKernelModules = fretwire.lib.read ./modules.few;
    kernelPackages = pkgs.linuxPackages_latest;
    loader.grub.device = "/dev/disk/by-id/ata-Samsung_SSD_860_EVO_250GB_S4BFNG0MB26329K";
  };
  fileSystems = {
    "/" = {
      # Try removing after upgrading
      # Fails to boot with auto!?
      fsType = "ext4";
      label = "nixos";
    };
    "/backup" = {
      fsType = "auto";
      label = "backup";
      options = [
        "nofail"
        "x-systemd.device-timeout=30s"
      ];
    };
  };
  hardware.amdgpu.initrd.enable = true;
  services.xserver = {
    displayManager.setupCommands = ''
      ${lib.getExe pkgs.setxkbmap}
      ${lib.getExe pkgs.xset} -dpms
    '';
    xkb.options = "caps:swapescape,ctrl:swap_rwin_rctl";
    xrandrHeads = [
      {
        monitorConfig = ''
          Option "Rotate" "left"
        '';
        output = "HDMI-1";
      }
      {
        output = "DVI-D-1";
        primary = true;
      }
      "HDMI-2"
    ];
  };
  system.stateVersion = "20.09";
}
