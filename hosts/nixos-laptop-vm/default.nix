{ modulesPath, pkgs, ... }: {
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
    "/" = {
      fsType = "ext4";
      label = "nixos";
    };
    "/home/nazar" /* so that klunok doesn't shadow the portal */ = {
      device = "/home/nazar";
      fsType = "auto";
      options = [
        "bind"
      ];
    };
    "/home/nazar/portal" = {
      device = "portal";
      fsType = "virtiofs";
    };
  };
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
  ];
  services = {
    libinput = {
      mouse.disableWhileTyping = true;
      touchpad.disableWhileTyping = true;
    };
    qemuGuest.enable = true;
    xserver.xrandrHeads = [
      {
        monitorConfig = ''
          Option "PreferredMode" "1920x1080"
        '';
        output = "Virtual-1";
      }
    ];
  };
  system.stateVersion = "25.11";
}
