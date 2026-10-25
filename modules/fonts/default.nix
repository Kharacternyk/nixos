{
  fretwire,
  host,
  ibm-plex,
  lib,
  pkgs,
  ...
}:
lib.optionalAttrs (host ? hasScreen) {
  fonts = {
    enableDefaultPackages = false;
    fontconfig = {
      defaultFonts = {
        emoji = [
          "Noto Emoji"
        ];
        monospace = [
          "IBM Plex Mono"
        ];
        sansSerif = [
          "IBM Plex Sans"
        ];
        serif = [
          "IBM Plex Serif"
        ];
      };
      localConf = builtins.readFile ./fontconfig.xml;
    };
    packages = fretwire.lib.import pkgs ./packages.few ++ [
      (pkgs.linkFarm "ibm-plex-ttf" {
        "share/fonts/truetype" = ibm-plex;
      })
    ];
  };
}
