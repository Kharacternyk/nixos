{ lib, host, pkgs, ... }:
let
  klunok = host.inputs.klunok.packages.${pkgs.system}.default + "/bin/klunok";
  commandLine = configurationFile: ''
    ${klunok} -c ${configurationFile} -d /klunok -w /home/nazar -w /etc/nixos -e /nix/store
  '';
in
{
  system.activationScripts = {
    klunok.text = ''
      mkdir -p /klunok
      chown klunok:klunok /klunok
      for path in /home/nazar /home/nazar/.bash_history; do
        ${pkgs.acl}/bin/setfacl -m u:klunok:rx -m mask:rx $path
      done
    '';
  };
  systemd.services = {
    klunok = {
      script = commandLine ./config.lua;
      wantedBy = [
        "multi-user.target"
      ];
    };
    klunok-valgrind.script = let valgrind = "${pkgs.valgrind-light}/bin/valgrind"; in ''
      ${valgrind} --leak-check=full -- ${commandLine ./config-valgrind.lua}
    '';
  };
  users = {
    groups.klunok = { };
    users.klunok = {
      isSystemUser = true;
      group = "klunok";
    };
  };
}
