{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    lf
  ];
  environment.etc = {
    "lf/lfrc".source = ./lfrc;
  };
}
