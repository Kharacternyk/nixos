{ config, ... }: {
  systemd = {
    services.prune = {
      path = [
        config.nix.package
      ];
      script = builtins.readFile ./prune.sh;
      serviceConfig.Type = "oneshot";
    };
    timers.prune = {
      timerConfig = {
        OnCalendar = "Sat *-*-* 08:00:00";
        Persistent = "yes";
        Unit = "prune.service";
      };
      wantedBy = [
        "timers.target"
      ];
    };
  };
}
