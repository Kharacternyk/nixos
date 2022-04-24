{ inputs, headless, pkgs, ... }: if headless then { } else
let
  qb = pkgs.writeShellScriptBin "qb" ''
    socket="$XDG_RUNTIME_DIR/qutebrowser/ipc-$(echo -n "$USER" | md5sum | cut -d' ' -f1)"
    printf \
    '{"args":["%s"],"target_arg":null,"version":"1.0.4","protocol_version":1,"cwd":"%s"}\n' \
    "$1" \
    "$PWD" \
    | ${pkgs.socat}/bin/socat -lf /dev/null - UNIX-CONNECT:"$socket" \
    || "${pkgs.qutebrowser}/bin/qutebrowser" -C ${./qutebrowser.py} "$@" &
  '';
  qbDesktop = pkgs.makeDesktopItem {
    name = "qb";
    desktopName = "Qutebrowser";
    exec = "${qb}/bin/qb %u";
  };
in
{
  environment.systemPackages = [
    pkgs.qutebrowser
    qb
    qbDesktop
  ];
}
