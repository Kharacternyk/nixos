{ pkgs, ... }: {
  environment = {
    etc.gitconfig.source = ./gitconfig;
    systemPackages = [
      pkgs.git
    ];
  };
}
