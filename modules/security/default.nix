{
  boot.initrd.systemd.settings.Manager.NoNewPrivileges = true;
  security = {
    account-utils.enable = true;
    enableWrappers = false;
    pki.caCertificateBlacklist = [
      "Comodo AAA Services root"
    ];
    polkit = {
      adminIdentities = [ ];
      extraConfig = builtins.readFile ./polkit.js;
    };
    protectKernelImage = true;
    run0.enable = true;
    sudo.enable = false;
  };
}
