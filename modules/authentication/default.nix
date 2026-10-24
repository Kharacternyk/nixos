{ lib, host, pkgs, ... }: {
  environment.systemPackages = lib.optionals (host ? hasScreen) [
    pkgs.yubikey-manager
  ];
  security.pam = {
    rssh = lib.optionalAttrs (!host ? hasScreen) {
      enable = true;
      settings = {
        ssh_agent_addr = "/run/user/1984/ssh-agent-fw";
        auth_key_file = "${../users/authorized_keys}";
      };
    };
    services.polkit-1.rssh = !host ? hasScreen;
    u2f = lib.optionalAttrs (host ? hasScreen) {
      enable = true;
      settings = {
        authfile = pkgs.writeText "u2f.txt" (
          let
            readKey = file: "*,${lib.strings.trim (builtins.readFile file)},es256,+presence";
            dantooine = readKey ./keys/dantooine.txt;
            yavin = readKey ./keys/yavin.txt;
            hoth = readKey ./keys/hoth.txt;
            keyList =
              if host ? usesDantooine then [
                dantooine
                hoth
                yavin
              ] else [
                hoth
                dantooine
                yavin
              ];
            keyString = builtins.concatStringsSep ":" keyList;
          in
          lib.strings.concatMapStrings (user: "${user}:${keyString}\n") [
            "nazar"
            "x-wing"
            "y-wing"
          ]
        );
        origin = "nixos";
      };
    };
  };
  programs.ssh = {
    agentTimeout = null;
    enableAskPassword = false;
    startAgent = true;
  };
  services.openssh = {
    authorizedKeysInHomedir = false;
    settings = {
      # The EC2 profile explicitly enables root login with SSH keys.
      PermitRootLogin = lib.mkForce "no";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };
  users = {
    allowNoPasswordLogin = true;
    mutableUsers = false;
  };
}
