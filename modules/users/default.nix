{
  users.users =
    let
      user = uid: {
        inherit uid;
        isNormalUser = true;
        openssh.authorizedKeys.keyFiles = [
          ./authorized_keys
        ];
      };
    in
    {
      nazar = user 1000;
      x-wing = user 1984;
      y-wing = user 2048;
    };
}
