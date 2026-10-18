{
  users.users = {
    nazar = {
      extraGroups = [
        "networkmanager"
      ];
      isNormalUser = true;
      openssh.authorizedKeys.keyFiles = [
        ./authorized_keys
      ];
      uid = 1000;
    };
    wheel = {
      extraGroups = [
        "wheel"
      ];
      isNormalUser = true;
      openssh.authorizedKeys.keyFiles = [
        ./authorized_keys
      ];
      uid = 2000;
    };
  };
}
