{ pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];
  networking = rec {
    hostName = "nixos-desktop";
    useDHCP = false;
    interfaces.wlp2s0u1u4.useDHCP = false;
    networkmanager.enable = true;
    firewall.allowedTCPPorts = [ ];
    firewall.allowedUDPPorts = firewall.allowedTCPPorts;
  };
  services.xserver.xrandrHeads = [
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
  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/sda";
  };
  system.stateVersion = "20.09";
}
