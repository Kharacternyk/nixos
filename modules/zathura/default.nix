{ lib, host, pkgs, ... }: lib.optionalAttrs (host ? hasScreen) {
  environment.systemPackages = [
    pkgs.zathura
  ];
  environment.etc.zathurarc.source = ./zathurarc;
}
