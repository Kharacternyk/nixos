{ pkgs, ... }: {
  environment = {
    etc."lf/lfrc".source = ./lfrc;
    systemPackages = [
      pkgs.lf
      pkgs.pistol
      pkgs.ranger
    ];
  };
}
