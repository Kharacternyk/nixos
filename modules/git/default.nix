{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    git
    gitAndTools.pre-commit
  ];
  environment.etc = {
    gitconfig.source = ./gitconfig;
  };
}
