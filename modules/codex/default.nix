{ lib, host, pkgs, ... }: (lib.optionalAttrs (host ? lacksSensibility) {
  environment = {
    shellAliases.codex = "XDG_RUNTIME_DIR=/tmp codex";
    systemPackages = [
      pkgs.codex
    ];
  };
})
