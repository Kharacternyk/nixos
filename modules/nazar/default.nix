{ pkgs, ... }: {
  users.users.nazar = {
    uid = 1000;
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "dialout"
    ];
  };
}
