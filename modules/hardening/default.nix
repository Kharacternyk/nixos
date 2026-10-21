{ host, lib, ... }: {
  boot.initrd.systemd.settings.Manager.NoNewPrivileges = true;
  security = {
    account-utils.enable = true;
    enableWrappers = false;
    pki.caCertificateBlacklist = [
      "Comodo AAA Services root"
      "emSign ECC Root CA - G3"
    ];
    polkit.extraConfig = builtins.readFile ./polkit.js;
    protectKernelImage = true;
    run0.enable = true;
    sudo.enable = false;
  };
  systemd = {
    services = {
      "polkit-agent-helper@".serviceConfig = lib.optionalAttrs
        (!host ? hasScreen)
        {
          ProtectHome = "read-only";
        };
    } // lib.optionalAttrs (host ? hasBackup) {
      systemd-tmpfiles-resetup.after = [
        "backup.mount"
      ];
      systemd-tmpfiles-setup.after = [
        "backup.mount"
      ];
    };
    tmpfiles.settings.hardening = lib.genAttrs
      ([ "/klunok" ] ++ lib.optional (host ? hasBackup) "/backup")
      (_: {
        "a+".argument = "u:nazar:rx,g::---,m::rx,o::---";
      });
  };
}
