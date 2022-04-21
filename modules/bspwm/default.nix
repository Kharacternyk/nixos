{ inputs, headless, pkgs, ... }: if headless then { } else {
  environment.systemPackages = with pkgs; [
    (stdenv.mkDerivation rec {
      name = "bspwm-utils";
      installPhase = "install -Dm755 ./ubspc.sh $out/bin/ubspc";
      src = inputs.bspwm-utils;
    })
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
