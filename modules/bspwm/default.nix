{ lib, bspwm-utils, host, pkgs, ... }: lib.optionalAttrs (host ? hasScreen) {
  environment.systemPackages =
    let
      clutter = name: command: pkgs.writeShellScriptBin name ''
        clutter() { systemctl --user $1 unclutter-xfixes; }
        clutter stop
        ${command}
        clutter start
      '';
    in
    [
      bspwm-utils.defaultPackage.${host.system}
      (clutter "crosshair" "xcolor -s")
      (clutter "screenshot" "import screenshot.png")
    ];
  services.xserver.windowManager.bspwm =
    let
      bspwmrc = pkgs.writeShellScriptBin "bspwmrc" (builtins.readFile ./bspwmrc);
    in
    {
      enable = true;
      configFile = "${bspwmrc}/bin/bspwmrc";
      sxhkd.configFile = ./sxhkdrc;
    };
}
