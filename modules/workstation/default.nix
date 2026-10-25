{
  fretwire,
  host,
  lib,
  pkgs,
  ...
}:
lib.optionalAttrs (host ? hasScreen) {
  environment = {
    etc."xdg/mimeapps.list".text = ''
      [Default Applications]
      x-scheme-handler/http=cb.desktop
      x-scheme-handler/https=cb.desktop
      application/pdf=org.pwmt.zathura.desktop
    '';
    systemPackages = fretwire.lib.import pkgs ./packages.few;
  };
  hardware.enableAllFirmware = true;
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
}
