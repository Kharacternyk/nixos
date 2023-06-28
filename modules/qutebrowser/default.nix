{ lib, host, pkgs, ... }:
let
  qb = pkgs.writeShellScriptBin "qb" ''
    socket="$XDG_RUNTIME_DIR/qutebrowser/ipc-$(echo -n "$USER" | md5sum | cut -d' ' -f1)"
    printf \
    '{"args":["%s"],"target_arg":null,"version":"1.0.4","protocol_version":1,"cwd":"%s"}\n' \
    "$1" \
    "$PWD" \
    | ${lib.getExe pkgs.socat} -lf /dev/null - UNIX-CONNECT:"$socket" \
    || "${lib.getExe pkgs.qutebrowser}" -C ${./qutebrowser.py} "$@" &
  '';
  qbDesktop = pkgs.makeDesktopItem {
    name = "qb";
    desktopName = "Qutebrowser";
    exec = "${lib.getExe qb} %u";
  };
in
lib.optionalAttrs (host ? hasScreen) {
  environment.systemPackages = [
    pkgs.qutebrowser
    qb
    qbDesktop
  ];
}
