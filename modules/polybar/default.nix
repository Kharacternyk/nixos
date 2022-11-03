{ lib, headless, gpu, pkgs, ... }: lib.optionalAttrs (!headless) {
  environment.systemPackages = with pkgs; [
    (polybar.override {
      alsaSupport = false;
      pulseSupport = true;
    })
  ];
  environment.etc = {
    "polybar.conf".text = builtins.readFile ./polybar.conf + lib.optionalString (!gpu) ''
      [settings]
      pseudo-transparency = true
    '';
  };
}
