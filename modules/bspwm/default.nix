{ lib, host, pkgs, ... }: lib.optionalAttrs (host ? hasScreen) {
  environment.systemPackages =
    let
      xcolor-clutter = pkgs.writeShellScriptBin "xcolor-clutter" ''
        systemctl --user stop unclutter-xfixes.service
        xcolor -s
        systemctl --user start unclutter-xfixes.service
      '';
    in
    [
      host.inputs.bspwm-utils.defaultPackage.${pkgs.system}
      xcolor-clutter
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
