{ host, modulesPath, pkgs, ... }: {
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
  ];
  boot = {
    initrd.availableKernelModules = [
      "ahci"
      "xhci_pci"
      "sr_mod"
    ];
    kernelModules = [
      "kvm-intel"
    ];
    kernelPackages = pkgs.linuxPackages_latest;
    loader.grub.device = "/dev/vda";
  };
  fileSystems = {
    "/".label = "nixos";
    "/home/nazar/portal" = {
      fsType = "virtiofs";
      device = "portal";
    };
  };
  services.xserver.xrandrHeads = [
    {
      output = "Virtual-1";
      monitorConfig = ''
        Option "PreferredMode" "1920x1080"
      '';
    }
  ];
  system.stateVersion = "25.11";
}
