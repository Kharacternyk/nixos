{ lib, host, pkgs, ... }: {
  environment.systemPackages = lib.optionals (host ? hasScreen) [
    pkgs.yubikey-manager
  ];
  security.pam = {
    rssh = lib.optionalAttrs (!host ? hasScreen) {
      enable = true;
      settings.auth_key_file = "${../nazar/authorized_keys}";
    };
    services.sudo.rssh = !host ? hasScreen;
    u2f = lib.optionalAttrs (host ? hasScreen) {
      enable = true;
      settings = {
        authfile = pkgs.writeText "u2f.txt" (
          let
            readKey = file: "*,${lib.strings.trim (builtins.readFile file)},es256,+presense";
            dantooine = readKey ./keys/dantooine.txt;
            hoth = readKey ./keys/hoth.txt;
            keyList = if host ? usesDantooine then [ dantooine hoth ] else [ hoth dantooine ];
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
  security.sudo = {
    execWheelOnly = true;
    extraConfig = ''
      Defaults env_keep+=SSH_AUTH_SOCK
    '';
  };
  users = {
    allowNoPasswordLogin = true;
    mutableUsers = false;
  };
}
