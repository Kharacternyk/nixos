{ inputs, dev, pkgs, ... }: if !dev then { } else {
  environment.systemPackages = with pkgs; [
    poetry
    yarn
    gnumake
    asciidoctor-with-extensions
    darkhttpd
    aws-sam-cli
  ];
}
