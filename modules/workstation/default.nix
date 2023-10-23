{ lib, host, functions, pkgs, ... }: lib.optionalAttrs (host ? hasScreen) {
  environment = {
    etc."xdg/mimeapps.list".text = ''
      [Default Applications]
      x-scheme-handler/http=qb.desktop
      x-scheme-handler/https=qb.desktop
      image/jpeg=qb.desktop
      image/png=qb.desktop
      image/svg+xml=qb.desktop
      application/pdf=org.pwmt.zathura.desktop
    '';
    systemPackages = functions.readAttributes ./packages.txt pkgs ++ [
      pkgs.apple-cursor
    ];
  };
  programs.adb.enable = true;
  security.rtkit.enable = true;
  services = {
    earlyoom = {
      enable = true;
      freeMemThreshold = 5;
    };
    picom = {
      enable = host ? hasGpu;
      backend = "glx";
      vSync = true;
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
    redshift = {
      enable = true;
      temperature = {
        day = 6500;
        night = 3500;
      };
    };
    udev.packages = [
      pkgs.yubikey-personalization
    ];
    unclutter-xfixes.enable = true;
    xserver = {
      enable = true;
      displayManager.lightdm.background = ./wallpaper.png;
      layout = "us,ua";
      xkbOptions = "caps:swapescape,grp:shifts_toggle,compose:lctrl,ctrl:swap_lwin_lctl";
    };
  };
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
        OnActiveSec = 15 * 60;
        OnUnitActiveSec = OnActiveSec;
        Unit = "pomodoro-lockscreen.service";
      };
      wantedBy = [
        "default.target"
      ];
    };
  };
}
