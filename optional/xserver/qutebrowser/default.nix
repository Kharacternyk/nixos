{ pkgs, ... }:
let
  qutebrowserWithQutelaunch = with pkgs; (qutebrowser.overridePythonAttrs (
    old: {
      propagatedBuildInputs = old.propagatedBuildInputs ++ [
        (pkgs.python3Packages.buildPythonPackage {
          name = "qutelaunch";
          src = fetchFromGitHub {
            owner = "Kharacternyk";
            repo = "qutelaunch";
            rev = "master";
            sha256 = "1yqjfnqswsjqv26fxlj5hrfnd4cxv0x1bg219q1mykz5gmams8xd";
          };
          propagatedBuildInputs = with pkgs; [
            python3Packages.flask
          ];
        })
      ];
    }
  )
  );
  qb = pkgs.writeShellScriptBin "qb" ''
    ${qutebrowserWithQutelaunch}/share/qutebrowser/scripts/open_url_in_instance.sh "$@"
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
    qutebrowserWithQutelaunch
    qb
    qbDesktop
  ];
  environment.etc = {
    "qutebrowser.py".source = ./qutebrowser.py;
  };
}