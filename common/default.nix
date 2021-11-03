{ pkgs, ... }: {
  imports = [
    ./bash
    ./neovim
  ];
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
  };
  environment.systemPackages = with pkgs; [
    bottom
    clang-tools
    entr
    fzf
    gdb
    git
    gitAndTools.pre-commit
    killall
    lf
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
  environment.etc = {
    inputrc.source = ./inputrc;
    gitconfig.source = ./gitconfig;
    "lf/lfrc".source = ./lfrc;
  };
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
}
