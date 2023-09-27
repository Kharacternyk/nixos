{ config, ... }: {
  systemd = {
    services.collect-garbage = {
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
      serviceConfig = {
        Restart = "no";
        Type = "oneshot";
      };
    };
    timers.collect-garbage = {
      timerConfig = {
        OnCalendar = "weekly";
        Persistent = "yes";
        Unit = "collect-garbage.service";
      };
      wantedBy = [
        "timers.target"
      ];
    };
  };
}
