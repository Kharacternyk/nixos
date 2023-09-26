{ lib, pkgs, host, ... }: {
  security.pam.u2f = lib.optionalAttrs (host ? hasScreen) {
    enable = true;
    authFile = ./u2f;
    origin = "nixos";
  };
  environment.systemPackages = lib.optionals (host ? hasScreen) [
    pkgs.yubikey-manager
  ];
  users = {
    allowNoPasswordLogin = true;
    mutableUsers = false;
  };
}
