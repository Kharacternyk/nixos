{ lib, headless, gpu, pkgs, ... }: lib.optionalAttrs (!headless) {
  environment.systemPackages = with pkgs; [
    firefox
    graphviz
    imagemagick
    inkscape
    libreoffice
    mpv
    pavucontrol
    spotify
    tdesktop
    xsel
    yubikey-manager
  ];
  services = {
    xserver = {
      enable = true;
      layout = "us,ua";
      xkbOptions = "caps:swapescape,grp:shifts_toggle,compose:lctrl,ctrl:swap_lwin_lctl";
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
    earlyoom = {
      enable = true;
      freeMemThreshold = 5;
    };
    udev.packages = [
      pkgs.yubikey-personalization
    ];
  };
  security.rtkit.enable = true;
  environment.etc."xdg/mimeapps.list".text = ''
    [Default Applications]
    x-scheme-handler/http=qb.desktop
    x-scheme-handler/https=qb.desktop
    image/jpeg=qb.desktop
    image/png=qb.desktop
    image/svg+xml=qb.desktop
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
