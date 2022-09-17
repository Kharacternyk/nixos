{ dev, usb, pkgs, ... }: if !dev then { } else {
  environment.systemPackages = with pkgs; [
    darkhttpd
    gnumake
    poetry
    yarn
    yarn-bash-completion
    dart
    flutter
    hover
  ] ++ (if usb then [ android-studio ] else [ ]);

  programs.adb.enable = usb;
}
