{ modulesPath, ... }: {
  imports = [
    "${modulesPath}/virtualisation/amazon-image.nix"
  ];
  security.pam = {
    rssh = {
      enable = true;
      auth_key_file = "${../../modules/nazar/authorized_keys}";
    };
    services.sudo.rssh = true;
  };
  services.amazon-ssm-agent.enable = lib.mkForce false;
}
