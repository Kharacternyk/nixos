{
  lib,
  ...
}:
{
  systemd.tmpfiles.settings =
    let
      users = [
        "x-wing"
        "y-wing"
      ];
      wipeHome = user: {
        name = "wipe-home-${user}";
        value = {
          "/home/${user}" = {
            "R!" = { };
            d = {
              inherit user;
              group = "users";
              mode = "0700";
            };
          };
          "/home/${user}/.bash_history".x = { };
        };
      };
    in
    lib.genAttrs' users wipeHome;
}
