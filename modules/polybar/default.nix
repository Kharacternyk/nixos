{ lib, host, pkgs, ... }: lib.optionalAttrs (host ? hasScreen) {
  environment.systemPackages = [
    (pkgs.polybar.override {
      alsaSupport = false;
      pulseSupport = true;
    })
  ];
  environment.etc."polybar.conf".text = builtins.readFile ./polybar.conf
    + lib.optionalString (!host ? hasGpu) ''
    [settings]
    pseudo-transparency = true
  '';
}
