{ lib, host, pkgs, ... }: {
  security.sudo.execWheelOnly = true;
  system.activationScripts.hardening = {
    deps = [
      "klunok"
    ];
    text =
      let
        maybeBackup = lib.optionalString (host ? hasBackup) "/backup";
      in
      ''
        chmod go-rwx /klunok ${maybeBackup}
        ${pkgs.acl}/bin/setfacl -m u:nazar:rx -m mask:rx /klunok ${maybeBackup}
      '';
  };
}
