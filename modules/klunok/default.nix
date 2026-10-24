{ host, klunok, pkgs, system, ... }: {
  systemd = {
    services =
      let
        package = klunok.packages.${system}.default;
        script = ''
          ${package}/bin/klunok \
          -c ${./config.lua} -d /klunok -w /home/nazar -e /nix/store
        '';
      in
      {
        klunok = {
          inherit script;
          environment.KLUNOK_SUFFIX = host.klunokSuffix;
          serviceConfig = {
            Restart = "on-failure";
            RestartMaxDelaySec = 5;
            RestartSteps = 5;
          };
          wantedBy = [
            "multi-user.target"
          ];
        };
        klunok-valgrind = {
          environment.KLUNOK_PREFIX = "klunok/valgrind";
          script = "${pkgs.valgrind-light}/bin/valgrind --leak-check=full -- ${script}";
        };
      };
    tmpfiles.settings.klunok = {
      "/home/nazar".a.argument = "u:klunok:rx,m::rx";
      "/home/nazar/.bash_history" = {
        a.argument = "u:klunok:r,m::r";
        f = {
          group = "users";
          mode = "0600";
          user = "nazar";
        };
      };
      "/klunok" = {
        a.argument = "u:nazar:rx,g::---,m::rx,o::---";
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
