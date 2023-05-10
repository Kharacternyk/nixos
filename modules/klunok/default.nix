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

  systemd.services.klunok-valgrind = {
    wantedBy = [
      "multi-user.target"
    ];
    script = ''
      ${pkgs.valgrind-light}/bin/valgrind --leak-check=full -- ${klunok}/bin/klunok -c ${./config-valgrind.lua} -d /klunok-valgrind -w /home/nazar -w /etc/nixos -e /nix/store
    '';
  };
  system.activationScripts.klunok-valgrind.text = ''
    mkdir -p /klunok-valgrind
    chown klunok:klunok /klunok-valgrind
  '';
}
