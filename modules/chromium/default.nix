{
  host,
  lib,
  pkgs,
  qbium,
  ...
}:
let
  inherit (pkgs) chromium;
  browserConfig = {
    inherit pkgs;
    hintKeys = "asdfghjkl";
    scrollStep = 80;
    searchUrl = "https://unduck.link/?q=";
    startPage = "https://wortschatz.link";
  };
  extension = qbium.lib.mkQbium browserConfig;
  launcher = pkgs.writeShellScriptBin "qbium" ''
    profile="''${XDG_CONFIG_HOME:-$HOME/.config}/chromium-keyboard"
    if [ "$#" -eq 0 ]; then
      set -- ${lib.escapeShellArg browserConfig.startPage}
    fi
    case "$1" in
      http://*|https://*) ;;
      *) exit 1 ;;
    esac
    exec ${lib.getExe chromium} \
      --user-data-dir="$profile" \
      --load-extension=${extension} \
      --new-window "$1"
  '';
in
lib.optionalAttrs (host ? hasScreen) {
  environment.systemPackages = [
    (pkgs.makeDesktopItem {
      desktopName = "Qbium";
      exec = "${lib.getExe launcher} %u";
      mimeTypes = [
        "x-scheme-handler/http"
        "x-scheme-handler/https"
      ];
      name = "qbium";
    })
    launcher
    chromium
  ];
  programs.chromium = {
    defaultSearchProviderEnabled = true;
    defaultSearchProviderSearchURL = "${browserConfig.searchUrl}{searchTerms}";
    enable = true;
    extraOpts = {
      AutoplayAllowed = false;
      BlockThirdPartyCookies = true;
      BrowserSignin = 0;
      DefaultGeolocationSetting = 2;
      DefaultNotificationsSetting = 2;
      DownloadDirectory = "\${user_home}/new";
      PasswordManagerEnabled = false;
      PromptForDownloadLocation = false;
      SpellcheckEnabled = true;
      SpellcheckLanguage = [
        "en-US"
        "uk"
      ];
      SyncDisabled = true;
      WebRtcIPHandling = "default_public_interface_only";
    };
    initialPrefs = lib.importJSON ./initial-preferences.json;
  };
}
