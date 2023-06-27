{ lib, inputs, headless, pkgs, ... }: lib.optionalAttrs (!headless) {
  environment.systemPackages = [
    inputs.bspwm-utils.defaultPackage.${pkgs.system}
  ];
  services.xserver.windowManager.bspwm =
    let
      bspwmrc = pkgs.writeShellScriptBin "bspwmrc" (builtins.readFile ./bspwmrc);
    in
    {
      enable = true;
      configFile = lib.getExe bspwmrc;
      sxhkd.configFile = ./sxhkdrc;
    };
}
