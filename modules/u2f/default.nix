{
  host,
  keys,
  lib,
  ...
}:
lib.optionalAttrs (host ? hasScreen) {
  security.pam.u2f = {
    enable = true;
    settings = {
      authfile = keys.u2f host.primaryKey [
        "nazar"
        "x-wing"
        "y-wing"
      ];
      origin = "nixos";
    };
  };
}
