{ lib, host, pkgs, ... }: (lib.optionalAttrs (host ? lacksSensibility) {
  environment.systemPackages = [
    pkgs.codex
  ];
})
