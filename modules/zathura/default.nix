{ lib, headless, pkgs, ... }: lib.optionalAttrs (!headless) {
  environment.systemPackages = with pkgs; [
    zathura
  ];
  environment.etc = {
    zathurarc.source = ./zathurarc;
  };
}
