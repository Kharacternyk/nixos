{ lib, host, pkgs, ... }: lib.optionalAttrs (host ? hasScreen) {
  environment = {
    etc."mpv/mpv.conf".source = ./mpv.conf;
    systemPackages = [
      pkgs.mpv
    ];
  };
}
