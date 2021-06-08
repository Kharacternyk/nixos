{ pkgs, ... }:
let qutebrowser_with_qutelaunch = with pkgs; (qutebrowser.overridePythonAttrs (
  old: {
    propagatedBuildInputs = (old.propagatedBuildInputs) ++ [
      (pkgs.python3Packages.buildPythonPackage {
        name = "qutelaunch";
        src = fetchFromGitHub {
          owner = "Kharacternyk";
          repo = "qutelaunch";
          rev = "master";
          sha256 = "0xkx0dbwc72d97dhzrnbfsjq0dxk5zfi6bji4k9wc1r3fwsz9zjw";
        };
        propagatedBuildInputs = with pkgs; [
          python3Packages.flask
        ];
      })
    ];
  }
)
); in
let qb = pkgs.writeShellScriptBin "qb" ''
  ${qutebrowser_with_qutelaunch}/share/qutebrowser/scripts/open_url_in_instance.sh "$@"
''; in
{
  environment.systemPackages = [
    pkgs.socat
    qutebrowser_with_qutelaunch
    qb
  ];
}
