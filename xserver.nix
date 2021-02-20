{pkgs, ...}: {
    environment.systemPackages = with pkgs; [
        mpv
        pulsemixer
        qutebrowser
        spotify
        tdesktop
        termite
        zathura
        zeroad
        zoom-us
    ];
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
            ibm-plex
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
