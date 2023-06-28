{ lib, host, pkgs, ... }: lib.optionalAttrs (host ? hasScreen) {
  fonts = {
    enableDefaultFonts = false;
    fonts = with pkgs; [
      (
        let version = "6.0.0"; in
        fetchzip {
          name = "ibm-plex-ttf-${version}";
          url = "https://github.com/IBM/plex/releases/download/v${version}/TrueType.zip";
          postFetch = ''
            mkdir -p $out/share/fonts
            unzip -oj $downloadedFile "TrueType/*/*.ttf" -d $out/share/fonts/truetype
          '';
          sha256 = "I4i/wr901yu7qp6zglBqsUSRVcetr3I0MBh9KqcuiLc=";
        }
      )
      font-awesome
      liberation_ttf
      noto-fonts-emoji
      noto-fonts-cjk
    ];
    fontconfig.defaultFonts = {
      monospace = [ "IBM Plex Mono" ];
      serif = [ "IBM Plex Serif" ];
      sansSerif = [ "IBM Plex Sans" ];
      emoji = [ "Noto Emoji" ];
    };
    fontconfig.localConf = ''
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
}
