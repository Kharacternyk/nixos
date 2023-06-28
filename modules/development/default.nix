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
    yarn
    yarn-bash-completion
  ] ++ (host ? hasEnoughStorage) [
    texlive.combined.scheme-full
  ] ++ (host ? hasScreen) [
    pandoc
    rstudio
  ];
}
