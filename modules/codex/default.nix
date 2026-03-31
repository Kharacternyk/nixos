{ lib, host, pkgs, ... }: (lib.optionalAttrs (host ? lacksSensibility) {
  environment = {
    shellAliases.codex = "XDG_RUNTIME_DIR=/tmp codex";
    systemPackages = [
      pkgs.codex
    ];
  };
  system.activationScripts.codex.text = ''
    mkdir -p /home/nazar/.codex
    ln -s ${./AGENTS.md} /home/nazar/.codex/AGENTS.md
  '';
})
