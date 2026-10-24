{ keys, ... }: {
  users = {
    allowNoPasswordLogin = true;
    mutableUsers = false;
    users =
      let
        user = uid: {
          inherit uid;
          isNormalUser = true;
          openssh.authorizedKeys.keyFiles = [
            keys.ssh
          ];
        };
      in
      {
        nazar = user 1000;
        x-wing = user 1984;
        y-wing = user 2048;
      };
  };
}
