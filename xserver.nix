{ lib, pkgs, ... }: {
  imports = [
    ./qutebrowser.nix
  ];
  environment.systemPackages = with pkgs; [
    alacritty
    graphviz
    imagemagick
    imv
    libreoffice
    mpv
    pulsemixer
    spotify
    tdesktop
    zathura
    zoom-us
    (stdenv.mkDerivation rec {
      pname = "bspwm-undo";
      version = "0.1";
      installPhase = "install -Dm755 ./ubspc.sh $out/bin/ubspc";
      src = fetchFromGitHub {
        owner = "Kharacternyk";
        repo = pname;
        rev = "v" + version;
        sha256 = "1399mb7lc5y1pwjz48c8rhx6cdj8859lqxx9wv9i2zzj6d04k2ni";
      };
    })
  ];
  environment.etc = {
    "alacritty.yaml".source = ./sources/alacritty.yaml;
    bspwmrc.source = ./sources/bspwmrc;
    bspwmrc.mode = "0755";
    "qutebrowser.py".source = ./sources/qutebrowser.py;
    sxhkdrc.source = ./sources/sxhkdrc;
    zathurarc.source = ./sources/zathurarc;
  };
  services.xserver = {
    enable = true;
    layout = "us,ua";
    xkbOptions = "caps:swapescape,grp:ctrls_toggle,compose:lctrl,ctrl:swap_lwin_lctl";
    displayManager.setupCommands = "${pkgs.xorg.setxkbmap}/bin/setxkbmap";
    windowManager.bspwm = {
      enable = true;
      configFile = "/etc/bspwmrc";
      sxhkd.configFile = "/etc/sxhkdrc";
    };
  };
  services.picom = {
    enable = true;
    vSync = true;
    backend = "glx";
  };
  services.redshift = {
    enable = true;
    temperature.day = 6500;
    temperature.night = 3500;
  };
  services.unclutter-xfixes.enable = true;
  fonts = {
    enableDefaultFonts = false;
    fonts = with pkgs; [
      (
        let version = "5.1.3"; in
        fetchzip {
          name = "ibm-plex-ttf-${version}";
          url = "https://github.com/IBM/plex/releases/download/v${version}/TrueType.zip";
          postFetch = ''
            mkdir -p $out/share/fonts
            unzip -oj $downloadedFile "TrueType/*/*.ttf" -d $out/share/fonts/truetype
          '';
          sha256 = "0pgxn7sj6w0qq2h1n7pzxw2pl8zg376kgd3czsczafvwa6bqnb4r";
        }
      )
      noto-fonts-emoji
      noto-fonts-cjk
    ];
    fontconfig.defaultFonts = {
      monospace = [ "IBM Plex Mono" ];
      serif = [ "IBM Plex Serif" ];
      sansSerif = [ "IBM Plex Sans" ];
    };
  };
  sound.enable = true;
  hardware.pulseaudio.enable = true;
}
