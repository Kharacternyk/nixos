{ lib, ... }: {
  systemd.tmpfiles.settings.users = lib.mergeAttrsList (map
    (name: {
      "/home/${name}"."D!" = {
        group = "users";
        mode = "0700";
        user = name;
      };
      "/home/${name}/.bash_history".x = {};
    })
    [ "x-wing" "y-wing" ]
  );
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
