{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    firefox
    graphviz
    imagemagick
    imv
    libreoffice
    mpv
    plantuml
    polybarFull
    pulsemixer
    spotify
    tdesktop
    thunderbird
    xsel
    zoom-us
  ];
  services = {
    earlyoom = {
      enable = true;
      ignoreOOMScoreAdjust = true;
    };
    xserver = {
      enable = true;
      layout = "us,ua";
      xkbOptions = "caps:swapescape,grp:ctrls_toggle,compose:lctrl,ctrl:swap_lwin_lctl";
    };
    picom = {
      enable = true;
      vSync = true;
      backend = "glx";
    };
    redshift = {
      enable = true;
      temperature.day = 6500;
      temperature.night = 3500;
    };
    unclutter-xfixes.enable = true;
  };
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };
  environment.etc."xdg/mimeapps.list".text = ''
    [Default Applications]
    x-scheme-handler/http=qb.desktop
    x-scheme-handler/https=qb.desktop
    image/jpeg=imv.desktop;
    application/pdf=org.pwmt.zathura.desktop
  '';
}
