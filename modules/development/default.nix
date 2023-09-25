{ lib, host, pkgs, ... }: lib.optionalAttrs (host ? isForDevelopment) {
  environment.systemPackages = with pkgs; [
    ansible
    clang-tools
    darkhttpd
    dart
    flutter
    gnumake
    nodePackages.wrangler
    poetry
    typst
    yarn
    yarn-bash-completion
  ] ++ lib.optionals (host ? hasScreen) [
    rstudio
  ];

  programs.adb.enable = true;
}
