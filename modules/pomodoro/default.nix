{
  host,
  lib,
  pkgs,
  ...
}:
lib.optionalAttrs (host ? hasScreen) {
  systemd.user = {
    services.pomodoro-lockscreen = {
      path = [
        pkgs.xsecurelock
      ];
      script = "xsecurelock";
      serviceConfig = {
        Restart = "no";
        Type = "oneshot";
      };
    };
    timers.pomodoro-lockscreen = {
      timerConfig = rec {
        OnActiveSec = "15m";
        OnUnitActiveSec = OnActiveSec;
        Unit = "pomodoro-lockscreen.service";
      };
      wantedBy = [
        "default.target"
      ];
    };
  };
}
