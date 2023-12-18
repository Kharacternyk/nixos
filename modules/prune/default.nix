{ config, ... }: {
  systemd = {
    services.collect-garbage = {
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
