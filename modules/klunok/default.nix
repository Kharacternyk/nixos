{ lib, host, pkgs, ... }:
let
  klunok = host.inputs.klunok.packages.${pkgs.system}.default + "/bin/klunok";
  commandLine = configurationFile: ''
    ${klunok} -c ${configurationFile} -d /klunok -w /home/nazar -w /etc/nixos -e /nix/store
  '';
in
{
  systemd.services.klunok = {
    wantedBy = [
      "multi-user.target"
    ];
    script = commandLine ./config.lua;
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
    wantedBy = lib.optionals (host ? hasEnoughRam && host ? isForDevelopment) [
      "multi-user.target"
    ];
    script = let valgrind = "${pkgs.valgrind-light}/bin/valgrind"; in ''
      ${valgrind} --leak-check=full -- ${commandLine ./config-valgrind.lua}
    '';
  };
  system.activationScripts.klunok-valgrind.text = ''
    mkdir -p /klunok-valgrind
    chown klunok:klunok /klunok-valgrind
  '';
}
