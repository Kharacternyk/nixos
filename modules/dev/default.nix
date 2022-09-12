{ dev, headless, pkgs, ... }: with {
  toggle = preference: ifTrue: ifFalse: if dev.${preference} or false then ifTrue else ifFalse;
}; {
  environment.systemPackages = with pkgs; ([
    darkhttpd
    gnumake
  ] ++ (toggle "python" [
    poetry
  ] [ ]) ++ (toggle "js" [
    yarn
    yarn-bash-completion
  ] [ ]) ++ (toggle "asciidoctor" [
    asciidoctor-with-extensions
  ] [ ]) ++ (toggle "aws" [
    aws-sam-cli
  ] [ ]) ++ (toggle "flutter" [
    dart
    flutter
    hover
  ] [ ]) ++ (toggle "chrome" [
    google-chrome
  ] [ ]) ++ (toggle "android" [
    android-studio
  ] [ ]) ++ (toggle "latex" [
    texlive.combined.scheme-full
  ] [ ]) ++ (toggle "r" [
    (if headless then R else rstudio)
  ] [ ]) ++ (toggle "pandoc" [
    pandoc
  ] [ ]) ++ (toggle "java" [
    jdk
    gradle
  ] [ ]));

  environment.variables = toggle "chrome"
    {
      CHROME_EXECUTABLE = "${pkgs.google-chrome}/bin/google-chrome-stable";
    }
    { };

  programs.adb.enable = toggle "android" true false;
}
