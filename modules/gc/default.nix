{ config, ... }: {
  systemd = {
    timers.collect-garbage = {
      wantedBy = [
        "timers.target"
      ];
      timerConfig = {
        Unit = "collect-garbage.service";
        Persistent = "yes";
        OnCalendar = "weekly";
      };
    };
    services.collect-garbage = {
      serviceConfig = {
        Type = "oneshot";
        Restart = "no";
      };
      path = [
        config.nix.package
      ];
      script = ''
        shopt -s nullglob
        nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 3d
        for profile in /home/*/src/*/.nix/profile; do
          nix profile wipe-history --profile "$profile"
        done
        nix store gc
      '';
    };
  };
}
