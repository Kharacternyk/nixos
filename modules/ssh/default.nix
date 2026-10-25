{
  host,
  lib,
  ...
}:
{
  programs.ssh = {
    agentTimeout = null;
    enableAskPassword = false;
    startAgent = host ? hasScreen;
  };
  services.openssh = {
    authorizedKeysInHomedir = false;
    settings = {
      KbdInteractiveAuthentication = false;
      PasswordAuthentication = false;
      # The EC2 profile explicitly enables root login with SSH keys.
      PermitRootLogin = lib.mkForce "no";
    };
  };
}
