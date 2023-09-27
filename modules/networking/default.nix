{ lib, host, ... }: {
  networking = {
    hostName = host.name;
  } // lib.optionalAttrs (host ? hasWifi) {
    networkmanager.enable = true;
    useDHCP = false;
  };
  systemd.services.NetworkManager-wait-online.enable = false;
}
