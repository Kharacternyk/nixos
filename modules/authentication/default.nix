{ lib, host, pkgs, ... }: {
  environment = {
    sessionVariables.SSH_AUTH_SOCK = lib.optionalString (!host ? hasScreen)
      "/run/user/1000/ssh-agent";
    systemPackages = lib.optionals (host ? hasScreen) [
      pkgs.yubikey-manager
    ];
  };
  security.pam = {
    rssh = lib.optionalAttrs (!host ? hasScreen) {
      enable = true;
      settings.auth_key_file = "${../nazar/authorized_keys}";
    };
    services.systemd-run0.rssh = !host ? hasScreen;
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
          "nazar:${keyString}\n"
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
  users = {
    allowNoPasswordLogin = true;
    mutableUsers = false;
  };
}
