{ inputs, headless, pkgs, ... }: if headless then { } else
let
  qb = pkgs.writeShellScriptBin "qb" ''
    ${pkgs.qutebrowser}/share/qutebrowser/scripts/open_url_in_instance.sh "$@"
  '';
  qbDesktop = pkgs.makeDesktopItem {
    name = "qb";
    desktopName = "Qutebrowser";
    exec = "${qb}/bin/qb %u";
  };
in
{
  environment.systemPackages = [
    pkgs.socat
    pkgs.qutebrowser
    qb
    qbDesktop
  ];
  environment.etc = {
    "qutebrowser.py".source = ./qutebrowser.py;
  };
}
