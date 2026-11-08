{ host, lib, ... }:
lib.optionalAttrs (host ? hasScreen) {
  networking.wg-quick.interfaces.wg = {
    autostart = true;
    configFile = "/root/wg.conf";
  };
}
