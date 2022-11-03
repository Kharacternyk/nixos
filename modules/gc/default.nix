{ config, ... }: {
  systemd = {
    timers.collect-garbage = {
      wantedBy = [
        "timers.target"
      ];
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
    paths.update-shells = {
      wantedBy = [
        "paths.target"
      ];
      pathConfig = {
        Unit = "update-shells.service";
        PathChanged = "/etc/static/nix/registry.json";
      };
    };
    services.update-shells = {
      serviceConfig = {
        Type = "oneshot";
        Restart = "no";
      };
      script = ''
        shopt -s nullglob
        for profile in /home/*/src/*/.nix/profile*; do
          unlink $profile
        done
      '';
    };
  };
}
