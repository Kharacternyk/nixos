{ lib, host, pkgs, ... }: {
  environment.systemPackages = lib.optionals (host ? hasScreen) [
    pkgs.yubikey-manager
  ];
  security.pam.u2f = lib.optionalAttrs (host ? hasScreen) {
    enable = true;
    authFile = pkgs.writeText "u2f.txt" (builtins.readFile ./u2f.txt);
    origin = "nixos";
  };
  users.allowNoPasswordLogin = true;
}
