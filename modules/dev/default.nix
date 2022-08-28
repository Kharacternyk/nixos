{ inputs, dev, pkgs, ... }: if !dev then { } else {
  environment.systemPackages = with pkgs; [
    poetry
    yarn
    yarn-bash-completion
    gnumake
    asciidoctor-with-extensions
    darkhttpd
    aws-sam-cli
    dart
    flutter
  ];
}
