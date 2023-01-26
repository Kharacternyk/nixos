{ lib, headless, gpu, pkgs, ... }: lib.optionalAttrs (!headless) {
  environment.systemPackages = with pkgs; [
    firefox
    graphviz
    imagemagick
    imv
    libreoffice
    mpv
    pavucontrol
    spotify
    tdesktop
    xsel
  ];
  services = {
    xserver = {
      enable = true;
      layout = "us,ua";
      xkbOptions = "caps:swapescape,grp:ctrls_toggle,compose:lctrl,ctrl:swap_lwin_lctl";
      displayManager = {
        lightdm.background = ./wallpaper;
      };
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
    picom = {
      enable = gpu;
      vSync = true;
      backend = "glx";
    };
    redshift = {
      enable = true;
      temperature.day = 6500;
      temperature.night = 3500;
    };
    unclutter-xfixes.enable = true;
    earlyoom.enable = true;
  };
  security.rtkit.enable = true;
  environment.etc."xdg/mimeapps.list".text = ''
    [Default Applications]
    x-scheme-handler/http=qb.desktop
    x-scheme-handler/https=qb.desktop
    image/jpeg=imv.desktop;
    application/pdf=org.pwmt.zathura.desktop
  '';
  systemd.user = {
    timers.pomodoro-lockscreen = {
      wantedBy = [
        "default.target"
      ];
      timerConfig = rec {
        Unit = "pomodoro-lockscreen.service";
        OnActiveSec = 30 * 60;
        OnUnitActiveSec = OnActiveSec;
      };
    };
    services.pomodoro-lockscreen = {
      serviceConfig = {
        Type = "oneshot";
        Restart = "no";
      };
      path = [
        pkgs.xsecurelock
      ];
      script = "xsecurelock";
    };
  };
}
