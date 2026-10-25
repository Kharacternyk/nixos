{ fretwire, host, ibm-plex, lib, pkgs, ... }: lib.optionalAttrs (host ? hasScreen) {
  fonts = {
    enableDefaultPackages = false;
    fontconfig = {
      defaultFonts = {
        emoji = [ "Noto Emoji" ];
        monospace = [ "IBM Plex Mono" ];
        sansSerif = [ "IBM Plex Sans" ];
        serif = [ "IBM Plex Serif" ];
      };
      localConf = ''
        <fontconfig>
          <match target="pattern">
            <test qual="any" name="family"><string>Arial</string></test>
            <edit name="family" mode="assign" binding="same">
              <string>sans-serif</string>
            </edit>
          </match>
          <match target="pattern">
            <test qual="any" name="family"><string>Consolas</string></test>
            <edit name="family" mode="assign" binding="same">
              <string>monospace</string>
            </edit>
          </match>
          <match target="pattern">
            <test qual="any" name="family"><string>Times</string></test>
            <edit name="family" mode="assign" binding="same">
              <string>serif</string>
            </edit>
          </match>
        </fontconfig>
      '';
    };
    packages = fretwire.lib.import pkgs ./packages.few ++ [
      (pkgs.linkFarm "ibm-plex-ttf" {
        "share/fonts/truetype" = ibm-plex;
      })
    ];
  };
}
