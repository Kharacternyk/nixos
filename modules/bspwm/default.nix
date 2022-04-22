{ inputs, headless, pkgs, ... }: if headless then { } else {
  environment.systemPackages = [
    inputs.bspwm-utils.defaultPackage.${pkgs.system}
  ];
  environment.etc = {
    bspwmrc.source = ./bspwmrc;
    bspwmrc.mode = "0755";
    sxhkdrc.source = ./sxhkdrc;
  };
  services.xserver.windowManager.bspwm = {
    enable = true;
    configFile = "/etc/bspwmrc";
    sxhkd.configFile = "/etc/sxhkdrc";
  };
}
