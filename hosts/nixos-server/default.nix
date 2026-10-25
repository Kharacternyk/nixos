{
  host,
  lib,
  modulesPath,
  pkgs,
  ...
}:
{
  hardware = lib.optionalAttrs (host ? hasCuda) {
    graphics.enable = true;
    nvidia.open = true;
    nvidia-container-toolkit.enable = true;
  };
  imports = [
    "${modulesPath}/virtualisation/amazon-image.nix"
  ];
  services = {
    amazon-ssm-agent.enable = lib.mkForce false;
    xserver.videoDrivers = lib.optionals (host ? hasCuda) [
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
      script = builtins.readFile ./auto-poweroff.sh;
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
