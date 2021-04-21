{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    fzf
    git
    gitAndTools.pre-commit
    lf
    man-pages
    mkpasswd
    neofetch
    nixpkgs-fmt
    ripgrep
    (
      let python-packages = packages: with packages; [
        pygments
      ]; in python3.withPackages python-packages
    )
  ];
  environment.etc = {
    inputrc.source = ./sources/inputrc;
    gitconfig.source = ./sources/gitconfig;
    "lf/lfrc".source = ./sources/lfrc;
  };
  environment.variables = {
    FZF_DEFAULT_OPTS = ''
      --bind=ctrl-l:accept,change:top
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
        OnCalendar = "Thu *-*-* 00:00:00";
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
  hardware.enableAllFirmware = true;
  nixpkgs.config.allowUnfree = true;
  time.timeZone = "Europe/Kiev";
  i18n.defaultLocale = "en_US.UTF-8";
  location = {
    provider = "manual";
    latitude = 50.45;
    longitude = 30.52;
  };
}
