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
    systemPackages = functions.readAttributes lib ./packages.txt pkgs;
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
      extraConfig.pipewire.overrides."context.properties"."default.clock.rate" = 44100;
      jack.enable = true;
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
      # CC BY-SA 4.0 by MultisampledNight
      # https://creativecommons.org/licenses/by-sa/4.0/
      displayManager.lightdm.background = ./wallpaper.png;
      xkb = {
        layout = "us,ua";
        options = "caps:swapescape,grp:shifts_toggle,compose:ins,ctrl:swap_lwin_lctl";
      };
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
