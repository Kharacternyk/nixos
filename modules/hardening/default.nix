{ lib, host, pkgs, ... }: {
  boot.initrd.systemd.settings.Manager.NoNewPrivileges = true;
  security = {
    account-utils.enable = true;
    enableWrappers = false;
    polkit.extraConfig = builtins.readFile ./polkit.js;
    pki.caCertificateBlacklist = [
      "Comodo AAA Services root"
      "emSign ECC Root CA - G3"
    ];
    protectKernelImage = true;
    run0.enable = true;
    sudo.enable = false;
  };
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
  systemd.services."polkit-agent-helper@".serviceConfig = lib.optionalAttrs
    (!host ? hasScreen)
    {
      ProtectHome = "read-only";
    };
}
