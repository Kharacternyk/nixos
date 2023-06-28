{ pkgs, ... }: {
  environment.systemPackages = [
    pkgs.git
  ];
  environment.etc.gitconfig.source = ./gitconfig;
}
