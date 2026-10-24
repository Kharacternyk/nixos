{ lib, ... }: {
  systemd.tmpfiles.settings =
    let
      wipeHome = user: {
        name = "wipe-home-${user}";
        value = {
          "/home/${user}"."D!" = {
            inherit user;
            group = "users";
            mode = "0700";
          };
          "/home/${user}/.bash_history".x = { };
        };
      };
    in
    lib.getAttrs' wipeHome [
      "x-wing"
      "y-wing"
    ];
}
