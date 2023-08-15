{ lib, host, pkgs, ... }: lib.optionalAttrs (host ? hasScreen) {
  environment.systemPackages = [
    host.inputs.bspwm-utils.defaultPackage.${pkgs.system}
  ];
  services.xserver.windowManager.bspwm = with {
    bspwmrc = pkgs.writeShellScriptBin "bspwmrc" (builtins.readFile ./bspwmrc);
  }; {
    enable = true;
    configFile = "${bspwmrc}/bin/bspwmrc";
    sxhkd.configFile = ./sxhkdrc;
  };
}
