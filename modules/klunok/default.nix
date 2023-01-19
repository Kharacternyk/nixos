{ inputs, pkgs, ... }:
let klunok = inputs.klunok.packages.${pkgs.system}.default; in
{
  systemd.services.klunok = {
    wantedBy = [
      "multi-user.target"
    ];
    restartTriggers = [
      klunok
    ];
    serviceConfig = {
      ExecStart = "${klunok}/bin/klunok /etc/klunok/config.lua";
    };
  };
  environment.etc."klunok/config.lua" = {
    mode = "0644";
    source = ./config.lua;
    user = "klunok";
    group = "klunok";
  };
}
