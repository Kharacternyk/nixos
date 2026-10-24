{ host, keys, lib, ... }: lib.optionalAttrs (!host ? hasScreen) {
  security.pam = {
    rssh = {
      enable = true;
      settings = {
        ssh_agent_addr = "/run/user/1984/ssh-agent-fw";
        auth_key_file = keys.ssh;
      };
    };
    services.polkit-1.rssh = true;
  };
  systemd.services."polkit-agent-helper@".serviceConfig.ProtectHome = "read-only";
}
