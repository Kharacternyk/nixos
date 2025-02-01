{ host, pkgs, ... }: {
  boot = {
    initrd.availableKernelModules = [
      "uhci_hcd"
      "ehci_pci"
      "ata_piix"
      "xhci_pci"
      "usbhid"
      "sd_mod"
    ];
    kernelPackages = pkgs.linuxPackages_latest;
    loader.grub = {
      enable = true;
      device = "/dev/sda";
    };
  };
  environment.systemPackages = [
    pkgs.alsa-scarlett-gui
  ];
  fileSystems = {
    "/".label = "nixos";
    "/backup".label = "backup";
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
