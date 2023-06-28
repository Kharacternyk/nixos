{ lib, host, ... }: {
  networking = {
    hostName = host.name;
  } // lib.optionalAttrs (host ? hasWifi) {
    useDHCP = false;
    networkmanager.enable = true;
  };
}
