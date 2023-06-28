{ pkgs, ... }: {
  environment.systemPackages = [
    pkgs.lf
  ];
  environment.etc."lf/lfrc".source = ./lfrc;
}
