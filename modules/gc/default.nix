{ pkgs, ... }: {
  systemd = {
    timers.collect-garbage = {
      wantedBy = [ "timers.target" ];
      timerConfig = {
        Unit = "collect-garbage.service";
        Persistent = "yes";
        OnCalendar = "daily";
      };
    };
    services.collect-garbage = {
      serviceConfig = {
        Type = "oneshot";
        Restart = "no";
      };
      script = ''
        ${pkgs.nix}/bin/nix-collect-garbage --delete-older-than 3d
      '';
    };
  };
}
