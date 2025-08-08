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
    "/home/nazar" /* so that klunok doesn't shadow the portal */ = {
      device = "/home/nazar";
      options = [
        "bind"
      ];
    };
    "/home/nazar/portal" = {
      device = "portal";
      fsType = "virtiofs";
    };
  };
  services = {
    libinput = {
      mouse.disableWhileTyping = true;
      touchpad.disableWhileTyping = true;
    };
    qemuGuest.enable = true;
    xserver.xrandrHeads = [
      {
        output = "Virtual-1";
        monitorConfig = ''
          Option "PreferredMode" "1920x1080"
        '';
      }
    ];
  };
  system.stateVersion = "25.11";
}
