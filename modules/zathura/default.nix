{ headless, pkgs, ... }: if headless then { } else {
  environment.systemPackages = with pkgs; [
    zathura
  ];
  environment.etc = {
    zathurarc.source = ./zathurarc;
  };
}
