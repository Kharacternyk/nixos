{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    (stdenv.mkDerivation rec {
      pname = "bspwm-utils";
      version = "0.2";
      installPhase = "install -Dm755 ./ubspc.sh $out/bin/ubspc";
      src = fetchFromGitHub {
        owner = "Kharacternyk";
        repo = pname;
        rev = "v" + version;
        sha256 = "loWrtURpxibJgoprNYENLNsuLTcv6hsk0xESe4i8ZXc=";
      };
    })
  ];
  environment.etc = {
    bspwmrc.source = ./bspwmrc;
    bspwmrc.mode = "0755";
    sxhkdrc.source = ./sxhkdrc;
  };
  services.xserver.windowManager.bspwm = {
    enable = true;
    configFile = "/etc/bspwmrc";
    sxhkd.configFile = "/etc/sxhkdrc";
  };
}
