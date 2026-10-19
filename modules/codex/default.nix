{ host, lib, pkgs, ... }: (lib.optionalAttrs (host ? lacksSensibility) {
  environment = {
    shellAliases.codex = "XDG_RUNTIME_DIR=/tmp codex";
    systemPackages = [
      pkgs.codex
    ];
  };
  systemd.tmpfiles.settings.codex = {
    "/home/nazar/.codex".d = {
      group = "users";
      mode = "0700";
      user = "nazar";
    };
    "/home/nazar/.codex/AGENTS.md"."L+" = {
      argument = "${./AGENTS.md}";
      group = "users";
      user = "nazar";
    };
  };
})
