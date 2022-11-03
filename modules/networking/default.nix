{ lib, hostname, headless, ... }: {
  networking = {
    hostName = hostname;
  } // lib.optionalAttrs (!headless) {
    useDHCP = false;
    networkmanager.enable = true;
  };
}
