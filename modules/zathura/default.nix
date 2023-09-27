{ lib, host, pkgs, ... }: lib.optionalAttrs (host ? hasScreen) {
  environment = {
    etc.zathurarc.source = ./zathurarc;
    systemPackages = [
      pkgs.zathura
    ];
  };
}
