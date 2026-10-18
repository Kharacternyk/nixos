{ lib, host, pkgs, ... }: {
  boot.initrd.systemd.settings.Manager.NoNewPrivileges = true;
  security = {
    account-utils.enable = true;
    enableWrappers = false;
    polkit.extraConfig = ''
      polkit.addRule(function(action, subject) {
        if (subject.user !== "root" && subject.user !== "wheel") {
          return polkit.Result.NO;
        }
        if (action.id === "org.freedesktop.systemd1.manage-units") {
          return polkit.Result.AUTH_ADMIN;
        }
      });
    '';
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
