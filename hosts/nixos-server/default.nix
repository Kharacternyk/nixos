{ lib, modulesPath, pkgs, ... }: {
  imports = [
    "${modulesPath}/virtualisation/amazon-image.nix"
  ];
  hardware = {
    graphics.enable = true;
    nvidia.open = true;
    nvidia-container-toolkit.enable = true;
  };
  services = {
    amazon-ssm-agent.enable = lib.mkForce false;
    xserver.videoDrivers = [
      "nvidia"
    ];
  };
  system.stateVersion = "22.05";
  systemd = {
    services.auto-poweroff = {
      path = [
        pkgs.procps
        pkgs.systemd
      ];
      script = ''
        [[ -n $(loginctl list-sessions --no-legend) ]] && exit
        pgrep tmux >/dev/null && exit

        logout_line="$(journalctl -u systemd-logind -g 'Removed session' -n 1 -o short-unix)"

        [[ -z "$logout_line" ]] && exit

        now="$(date +%s)"
        last_logout="''${logout_line%% *}"
        last_logout="''${last_logout%%.*}"

        [[ $((now - last_logout)) -lt $((30 * 60)) ]] && exit

        systemctl poweroff
      '';
      serviceConfig = {
        Restart = "no";
        Type = "oneshot";
      };
    };
    timers.auto-poweroff = {
      timerConfig = {
        OnBootSec = "45m";
        OnUnitActiveSec = "5m";
        Unit = "auto-poweroff.service";
      };
      wantedBy = [
        "timers.target"
      ];
    };
  };
}
