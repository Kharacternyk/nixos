{ fretwire, host, lib, ocenaudio, pkgs, ... }: lib.optionalAttrs (host ? hasScreen) {
  environment = {
    etc."xdg/mimeapps.list".text = ''
      [Default Applications]
      x-scheme-handler/http=cb.desktop
      x-scheme-handler/https=cb.desktop
      application/pdf=org.pwmt.zathura.desktop
    '';
    systemPackages = fretwire.lib.import pkgs ./packages.few ++ [
      (
        pkgs.ocenaudio.overrideAttrs (oldAttrs: {
          autoPatchelfIgnoreMissingDeps = [];
          buildInputs = oldAttrs.buildInputs ++ [
            pkgs.libxcrypt-legacy
          ];
          preInstall = ''
            # The nixpkgs install phase replaces this with its own bzip2 library.
            rm -f opt/ocenaudio/lib/libbz2.so.1.0
          '';
          src = builtins.path {
            name = "ocenaudio.deb";
            path = ocenaudio.outPath;
          };
          version = "latest";
        })
      )
    ];
  };
  hardware.enableAllFirmware = true;
  security.rtkit.enable = true;
  services = {
    earlyoom = {
      enable = true;
      freeMemThreshold = 5;
    };
    picom = {
      backend = "glx";
      enable = host ? hasGpu;
      vSync = true;
    };
    pipewire = {
      enable = true;
      extraConfig.pipewire.overrides."context.properties"."default.clock.allowed-rates" = [
        44100
        48000
        88200
        96000
        176400
        192000
      ];
      jack.enable = true;
    };
    redshift = {
      enable = true;
      temperature = {
        day = 6500;
        night = 3500;
      };
    };
    udev.packages = [
      pkgs.yubikey-personalization
    ];
    unclutter-xfixes.enable = true;
    xserver = {
      # CC BY-SA 4.0 by MultisampledNight
      # https://creativecommons.org/licenses/by-sa/4.0/
      displayManager.lightdm.background = ./wallpaper.png;
      enable = true;
      xkb = {
        layout = "us,ua";
        options = "grp:shifts_toggle,compose:ins,ctrl:swap_lwin_lctl";
      };
    };
  };
  systemd.user = {
    services.pomodoro-lockscreen = {
      path = [
        pkgs.xsecurelock
      ];
      script = "xsecurelock";
      serviceConfig = {
        Restart = "no";
        Type = "oneshot";
      };
    };
    timers.pomodoro-lockscreen = {
      timerConfig = rec {
        OnActiveSec = "15m";
        OnUnitActiveSec = OnActiveSec;
        Unit = "pomodoro-lockscreen.service";
      };
      wantedBy = [
        "default.target"
      ];
    };
  };
}
