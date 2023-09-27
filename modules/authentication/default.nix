{ lib, host, pkgs, ... }: {
  environment.systemPackages = lib.optionals (host ? hasScreen) [
    pkgs.yubikey-manager
  ];
  security.pam.u2f = lib.optionalAttrs (host ? hasScreen) {
    enable = true;
    authFile = ./u2f;
    origin = "nixos";
  };
  users = {
    allowNoPasswordLogin = true;
    mutableUsers = false;
  };
}
