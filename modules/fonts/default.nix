{ lib, functions, host, pkgs, ... }: lib.optionalAttrs (host ? hasScreen) {
  fonts = {
    enableDefaultPackages = false;
    packages = functions.readAttributes ./fonts.txt pkgs ++ [
      (
        let version = "6.0.0"; in
        pkgs.fetchzip {
          name = "ibm-plex-ttf-${version}";
          url = "https://github.com/IBM/plex/releases/download/v${version}/TrueType.zip";
          postFetch = ''
            mkdir -p $out/share/fonts
            unzip -oj $downloadedFile "TrueType/*/*.ttf" -d $out/share/fonts/truetype
          '';
          sha256 = "I4i/wr901yu7qp6zglBqsUSRVcetr3I0MBh9KqcuiLc=";
        }
      )
    ];
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
  };
}
