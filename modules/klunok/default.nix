{ inputs, pkgs, ... }:
let klunok = inputs.klunok.packages.${pkgs.system}.default; in
{
  systemd.services.klunok = {
    wantedBy = [
      "multi-user.target"
    ];
    restartTriggers = [
      klunok
      ./config.lua
    ];
    script = "${klunok}/bin/klunok -d /klunok -i / -c ${./config.lua}";
  };
  system.activationScripts.klunok.text = ''
    mkdir -p /klunok
    chown klunok:klunok /klunok
    for path in /home/nazar /etc/nixos /tmp; do
      if ! mountpoint -q $path; then
        ${pkgs.util-linux}/bin/mount --bind $path $path
      fi
    done
    for path in /home/nazar /home/nazar/.bash_history; do
      ${pkgs.acl}/bin/setfacl -m u:klunok:rx -m mask:rx $path
    done
  '';
  users.users.klunok = {
    isSystemUser = true;
    group = "klunok";
  };
  users.groups.klunok = { };
}
