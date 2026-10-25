{
  keys,
  lib,
  ...
}:
{
  users = {
    allowNoPasswordLogin = true;
    mutableUsers = false;
    users =
      lib.mapAttrs
        (_: uid: {
          inherit uid;
          # Homes are managed by tmpfiles.
          # Enabling breaks ACLs.
          createHome = false;
          isNormalUser = true;
          openssh.authorizedKeys.keyFiles = [
            keys.ssh
          ];
        })
        {
          nazar = 1000;
          x-wing = 1984;
          y-wing = 2048;
        };
  };
}
