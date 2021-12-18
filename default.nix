nixpkgs:
hostname:
{ headless ? false }:
let
  machineModule = ./machines + "/${hostname}/configuration.nix";
  commonModules = [
    ./modules/bash
    ./modules/dev
    ./modules/gc
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
        entr
        fzf
        killall
        man-pages
        mkpasswd
        neofetch
        nixpkgs-fmt
        ripgrep
        unzip
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
    ./modules/fonts
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
      sound.enable = true;
      hardware.pulseaudio.enable = true;
    })
  ];
in
commonModules ++ xserverModules ++ [ machineModule ]
