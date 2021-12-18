{ pkgs, ... }: {
  systemd = {
    timers.collect-garbage = {
      wantedBy = [ "timers.target" ];
      timerConfig = {
        Unit = "collect-garbage.service";
        Persistent = "yes";
        OnCalendar = "Sat *-*-* 00:00:00";
      };
    };
    services.collect-garbage = {
      serviceConfig = {
        Type = "oneshot";
        Restart = "no";
      };
      script = ''
        ${pkgs.nix}/bin/nix-collect-garbage --delete-older-than 7d
      '';
    };
  };
}
