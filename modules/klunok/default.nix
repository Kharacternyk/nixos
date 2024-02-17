{ lib, host, pkgs, ... }: {
  system.activationScripts = {
    klunok.text = ''
      mkdir -p /klunok
      chown klunok:klunok /klunok
      for path in /home/nazar /home/nazar/.bash_history; do
        ${pkgs.acl}/bin/setfacl -m u:klunok:rx -m mask:rx $path
      done
    '';
  };
  systemd.services =
    let
      script = ''
        ${host.inputs.klunok.packages.${pkgs.system}.default}/bin/klunok \
        -c ${./config.lua} -d /klunok -w /home/nazar -w /etc/nixos -e /nix/store
      '';
    in
    {
      klunok = {
        inherit script;
        wantedBy = [
          "multi-user.target"
        ];
      };
      klunok-valgrind = {
        environment.KLUNOK_PREFIX = "klunok/valgrind";
        script = "${pkgs.valgrind-light}/bin/valgrind --leak-check=full -- ${script}";
      };
    };
  users = {
    groups.klunok = { };
    users.klunok = {
      isSystemUser = true;
      group = "klunok";
    };
  };
}
