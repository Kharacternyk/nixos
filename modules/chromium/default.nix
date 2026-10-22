{ host, lib, pkgs, ... }:
let
  inherit (pkgs) chromium;
  cb = pkgs.writeShellScriptBin "cb" ''
    profile="''${XDG_CONFIG_HOME:-$HOME/.config}/chromium-keyboard"
    if [ "$#" -eq 0 ]; then
      set -- https://wortschatz.link
    fi
    case "$1" in
      http://*|https://*) ;;
      *) exit 1 ;;
    esac
    exec ${chromium}/bin/chromium \
      --user-data-dir="$profile" \
      --load-extension=${./extension} \
      --new-window "$1"
  '';
in
lib.optionalAttrs (host ? hasScreen) {
  environment.systemPackages = [
    cb
    chromium
    (pkgs.makeDesktopItem {
      name = "cb";
      desktopName = "Chromium Keyboard";
      exec = "${cb}/bin/cb %u";
      mimeTypes = [
        "x-scheme-handler/http"
        "x-scheme-handler/https"
      ];
    })
  ];
  programs.chromium = {
    enable = true;
    defaultSearchProviderEnabled = true;
    defaultSearchProviderSearchURL = "https://unduck.link/?q={searchTerms}";
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
    initialPrefs = builtins.fromJSON (builtins.readFile ./initial-preferences.json);
  };
}
