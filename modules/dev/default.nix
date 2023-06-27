{ lib, dev, usb, pkgs, headless, ... }: lib.optionalAttrs dev {
  environment.systemPackages = with pkgs; [
    clang-tools
    darkhttpd
    dart
    flutter
    gnumake
    poetry
    texlive.combined.scheme-full
    yarn
    yarn-bash-completion
  ] ++ lib.optionals (!headless) [
    pandoc
    rstudio
  ];

  programs.adb.enable = usb;
}
