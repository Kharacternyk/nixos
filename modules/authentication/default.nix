{ lib, host, ... }: {
  security.pam.u2f = {
    enable = true;
    authFile = ./u2f;
    origin = "nixos";
  };
  users = {
    allowNoPasswordLogin = true;
    mutableUsers = false;
  };
}
