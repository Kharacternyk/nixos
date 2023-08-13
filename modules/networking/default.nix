{ lib, host, ... }: {
  networking = {
    hostName = host.name;
  } // lib.optionalAttrs (host ? hasWifi) {
    useDHCP = false;
    networkmanager.enable = true;
  };
  systemd.services.NetworkManager-wait-online.enable = false;
}
