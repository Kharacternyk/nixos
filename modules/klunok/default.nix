{ inputs, pkgs, ... }:
let klunok = inputs.klunok.packages.${pkgs.system}.default; in
{
  systemd.services.klunok = {
    wantedBy = [
      "multi-user.target"
    ];
    script = ''
      ${klunok}/bin/klunok -c ${./config.lua} -d /klunok -w /home/nazar -w /etc/nixos -e /nix/store
    '';
  };
  system.activationScripts.klunok.text = ''
    mkdir -p /klunok
    chown klunok:klunok /klunok
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
