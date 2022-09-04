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
    google-chrome
    android-studio
  ];
  environment.variables = {
    CHROME_EXECUTABLE = "${pkgs.google-chrome}/bin/google-chrome-stable";
  };
  programs.adb.enable = true;
}
