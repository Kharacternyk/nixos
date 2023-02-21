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
      pkgs.util-linux
    ];
    script = ''
      mkdir -p /klunok
      chown klunok:klunok /klunok
      for path in /home/nazar /etc/nixos /tmp; do
        mount --bind $path $path
      done
      for path in /home/nazar /home/nazar/.bash_history; do
        setfacl -m u:klunok:rx -m mask:rx $path
      done
      klunok -d /klunok -i / -c ${./config.lua}
    '';
  };
  users.users.klunok = {
    isSystemUser = true;
    group = "klunok";
  };
  users.groups.klunok = { };
}
