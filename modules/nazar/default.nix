{
  users.users.nazar = {
    extraGroups = [
      "wheel"
      "networkmanager"
      "dialout"
      "adbusers"
    ];
    isNormalUser = true;
    openssh.authorizedKeys.keyFiles = [
      ./authorized_keys
    ];
    uid = 1000;
  };
}
