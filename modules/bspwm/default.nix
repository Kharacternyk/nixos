{
  bspwm-utils,
  host,
  lib,
  pkgs,
  system,
  ...
}:
lib.optionalAttrs (host ? hasScreen) {
  environment.systemPackages =
    let
      clutter =
        name: command:
        pkgs.writeShellScriptBin name ''
          clutter() { systemctl --user $1 unclutter-xfixes; }
          clutter stop
          ${command}
          clutter start
        '';
    in
    [
      (clutter "crosshair" "xcolor -s")
      (clutter "screenshot" "import screenshot.png")
      bspwm-utils.defaultPackage.${system}
    ];
  services.xserver.windowManager.bspwm =
    let
      bspwmrc = pkgs.writeShellScriptBin "bspwmrc" (builtins.readFile ./bspwmrc);
    in
    {
      configFile = lib.getExe bspwmrc;
      enable = true;
      sxhkd.configFile = ./sxhkdrc;
    };
}
