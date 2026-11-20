{
  host,
  klunok,
  lib,
  system,
  ...
}:
{
  systemd = {
    services.klunok = {
      environment.KLUNOK_SUFFIX = host.klunokSuffix;
      script = ''
        ${lib.getExe' klunok.packages.${system}.default "klunok"} \
        -c ${./config.lua} -d /klunok -w /home/nazar -e /nix/store
      '';
      serviceConfig = {
        Restart = "on-failure";
        RestartMaxDelaySec = 5;
        RestartSteps = 5;
      };
      wantedBy = [
        "multi-user.target"
      ];
    };
    tmpfiles.settings.klunok = {
      "/home/nazar" = {
        a.argument = "u:klunok:rx";
        d = {
          group = "users";
          mode = "0700";
          user = "nazar";
        };
      };
      "/home/nazar/.bash_history" = {
        a.argument = "u:klunok:r";
        f = {
          group = "users";
          mode = "0600";
          user = "nazar";
        };
      };
      "/klunok" = {
        a.argument = "u:nazar:rx";
        d = {
          group = "klunok";
          mode = "0700";
          user = "klunok";
        };
      };
    };
  };
  users = {
    groups.klunok.gid = 500;
    users.klunok = {
      group = "klunok";
      isSystemUser = true;
      uid = 500;
    };
  };
}
