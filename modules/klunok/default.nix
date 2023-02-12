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
      setfacl -m u:klunok:rx -m mask:rx /home/nazar
      klunok -d /klunok -i /
    '';
  };
  users.users.klunok = {
    isSystemUser = true;
    group = "klunok";
  };
  users.groups.klunok = { };
}
