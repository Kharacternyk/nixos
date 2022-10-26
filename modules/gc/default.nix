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
      path = [
        pkgs.nixFlakes
      ];
      script = ''
        nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 3d
        for profile in /home/*/src/*/.nix/profile; do
          nix profile wipe-history --profile "$profile"
        done
        nix store gc
      '';
    };
  };
}
