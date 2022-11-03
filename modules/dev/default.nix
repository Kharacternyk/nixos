{ lib, dev, usb, pkgs, headless, ... }: if !dev then { } else {
  environment.systemPackages = with pkgs; [
    clang-tools
    darkhttpd
    dart
    gnumake
    poetry
    texlive.combined.scheme-full
    yarn
    yarn-bash-completion
  ] ++ lib.lists.optionals (!headless) [
    pandoc
    rstudio
  ];

  programs.adb.enable = usb;
}
