{ pkgs, ... }: {
  environment.systemPackages = [
    pkgs.git
    pkgs.diff-so-fancy
  ];
  environment.etc.gitconfig.source = ./gitconfig;
}
