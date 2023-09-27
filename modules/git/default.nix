{ pkgs, ... }: {
  environment = {
    etc.gitconfig.source = ./gitconfig;
    systemPackages = [
      pkgs.diff-so-fancy
      pkgs.git
    ];
  };
}
