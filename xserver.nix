{lib, pkgs, ...}: {
    environment.systemPackages = with pkgs; [
        alacritty
        mpv
        pulsemixer
        qutebrowser
        spotify
        tdesktop
        zathura
        zeroad
        zoom-us
    ];
    environment.etc = {
        alacritty.source = ./sources/alacritty;
    };
    services.xserver = {
        enable = true;
        layout = "us,ua";
        xkbOptions = "caps:swapescape,grp:ctrls_toggle," +
                     "compose:lctrl,ctrl:swap_lwin_lctl";
        windowManager.bspwm.enable = true;
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
            (let version = "5.1.3"; in fetchzip {
                name = "ibm-plex-ttf-${version}";
                url = "https://github.com/IBM/plex/releases/download/" +
                      "v${version}/TrueType.zip";
                postFetch = ''
                    mkdir -p $out/share/fonts
                    unzip -oj $downloadedFile "TrueType/*/*.ttf" -d $out/share/fonts/truetype
                '';
                sha256 = "0pgxn7sj6w0qq2h1n7pzxw2pl8zg376kgd3czsczafvwa6bqnb4r";
            })
            noto-fonts-emoji
            noto-fonts-cjk
        ];
        fontconfig.defaultFonts = {
            monospace = ["IBM Plex Mono"];
            serif = ["IBM Plex Serif"];
            sansSerif = ["IBM Plex Sans"];
        };
    };
    sound.enable = true;
    hardware.pulseaudio.enable = true;
}
