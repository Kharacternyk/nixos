{ config, ... }: {
  systemd = {
    services.prune = {
      path = [
        config.nix.package
      ];
      script = ''
        shopt -s nullglob
        week_ago="$(date -d 'week ago' +%s)"

        nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 3d

        for root in /nix/var/nix/gcroots/auto/*; do
          target="$(readlink "$root")"

          if [[ $? = 0 ]]; then
            parent="$(dirname "$target")"
            basename="$(basename "$parent")"

            if [[ $basename = .nix ]]; then
              gitignore="$parent/.gitignore"

              if [[ -f $gitignore ]]; then
                last_used="$(date -r "$gitignore" +%s)"

                if (( last_used < week_ago )); then
                  unlink "$root"
                fi
              fi
            fi
          fi
        done

        nix store gc

        /nix/var/nix/profiles/system/bin/switch-to-configuration switch
      '';
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
