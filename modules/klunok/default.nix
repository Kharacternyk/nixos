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
    path = [
      klunok
      pkgs.acl
    ];
    script = ''
      mkdir -p /klunok
      chown klunok:klunok /klunok
      setfacl -m u:klunok:rx -m mask:rx /home/nazar
      klunok /etc/klunok/config.lua
    '';
  };
  environment.etc."klunok/config.lua" = {
    mode = "0644";
    source = ./config.lua;
    user = "klunok";
    group = "klunok";
  };
  users.users.klunok = {
    isSystemUser = true;
    group = "klunok";
  };
  users.groups.klunok = { };
}
