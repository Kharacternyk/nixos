{
  users.users.nazar = {
    extraGroups = [
      "wheel"
      "networkmanager"
      "dialout"
      "adbusers"
    ];
    isNormalUser = true;
    uid = 1000;
  };
}
