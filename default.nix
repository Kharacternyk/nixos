nixpkgs:
hostname:
{ headless ? false
,
}:
let
  machineModule = ./machines + "/${hostname}/configuration.nix";
  commonModules = [
    ./modules/bash
    ./modules/git
    ./modules/neovim
    ./modules/lf
    ({ pkgs, ... }: {
      users.users.nazar = {
        uid = 1000;
        isNormalUser = true;
        extraGroups = [
          "wheel"
          "networkmanager"
          "dialout"
        ];
      };
      nix = {
        package = pkgs.nixUnstable;
        extraOptions = ''
          experimental-features = nix-command flakes
        '';
        registry.nixpkgs.flake = nixpkgs;
      };
      environment.systemPackages = with pkgs; [
        bottom
        clang-tools
        entr
        fasm-bin
        fzf
        gdb
        killall
        man-pages
        mkpasswd
        neofetch
        nixpkgs-fmt
        nodejs
        ripgrep
        unzip
        valgrind
        (
          let python-packages = packages: with packages; [
            pygments
          ]; in python3.withPackages python-packages
        )
      ];
      environment.variables = {
        FZF_DEFAULT_OPTS = ''
          --bind=change:top
          --prompt='/ '
          --info=hidden
          --color fg:-1,bg:-1,hl:1,fg+:-1,bg+:-1,hl+:1
          --color prompt:4,spinner:4,marker:4,pointer:4
          --reverse
        '';
        LESSHISTFILE = "/dev/null";
        ELECTRON_SKIP_BINARY_DOWNLOAD = "1";
      };
      systemd = {
        timers.collect-garbage = {
          wantedBy = [ "timers.target" ];
          timerConfig = {
            Unit = "collect-garbage.service";
            Persistent = "yes";
            OnCalendar = "Sat *-*-* 00:00:00";
          };
        };
        services.collect-garbage = {
          serviceConfig = {
            Type = "oneshot";
            Restart = "no";
          };
          script = ''
            ${pkgs.nix}/bin/nix-collect-garbage --delete-older-than 7d
          '';
        };
      };
      services.earlyoom = {
        enable = true;
        ignoreOOMScoreAdjust = true;
      };
      nixpkgs.config.allowUnfree = true;
      time.timeZone = "Europe/Kiev";
      i18n.defaultLocale = "en_US.UTF-8";
      location = {
        provider = "manual";
        latitude = 50.45;
        longitude = 30.52;
      };
    })
  ];
  xserverModules = if headless then [ ] else [
    ./modules/alacritty
    ./modules/bspwm
    ./modules/qutebrowser
    ./modules/texlive
    ./modules/zathura
    ({ pkgs, ... }: {
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
      environment.etc = {
        "xdg/mimeapps.list".text = ''
          [Default Applications]
          x-scheme-handler/http=qb.desktop
          x-scheme-handler/https=qb.desktop
          image/jpeg=imv.desktop;
          application/pdf=org.pwmt.zathura.desktop
        '';
      };
      services.xserver = {
        enable = true;
        layout = "us,ua";
        xkbOptions = "caps:swapescape,grp:ctrls_toggle,compose:lctrl,ctrl:swap_lwin_lctl";
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
            let version = "6.0.0"; in
            fetchzip {
              name = "ibm-plex-ttf-${version}";
              url =
                "https://github.com/IBM/plex/releases/download/v${version}/TrueType.zip";
              postFetch = ''
                mkdir -p $out/share/fonts
                unzip -oj $downloadedFile "TrueType/*/*.ttf" -d $out/share/fonts/truetype
              '';
              sha256 = "I4i/wr901yu7qp6zglBqsUSRVcetr3I0MBh9KqcuiLc=";
            }
          )
          font-awesome
          noto-fonts-emoji
          noto-fonts-cjk
        ];
        fontconfig.defaultFonts = {
          monospace = [ "IBM Plex Mono" ];
          serif = [ "IBM Plex Serif" ];
          sansSerif = [ "IBM Plex Sans" ];
          emoji = [ "Noto Emoji" ];
        };
      };
      sound.enable = true;
      hardware.pulseaudio.enable = true;
    })
  ];
in
commonModules ++ xserverModules ++ [ machineModule ]
