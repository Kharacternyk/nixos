{ univ, pkgs, ... }: if !univ then { } else {
  environment.systemPackages = with pkgs; [
    texlive.combined.scheme-full
    rstudio
    pandoc
    jdk
    gradle
  ];
}
