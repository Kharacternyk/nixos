{ lib, host, pkgs, ... }:
let
  qutebrowser = pkgs.qutebrowser.overrideAttrs (attrs: {
    prePatch = ''
      cp ${host.inputs.qutebrowser-mypy} .mypy.ini
      chmod +w .mypy.ini
    '';
    patches = attrs.patches ++ [
      host.inputs.qutebrowser-patch
    ];
  });
  qb = pkgs.writeShellScriptBin "qb" ''
    socket="$XDG_RUNTIME_DIR/qutebrowser/ipc-$(echo -n $USER | md5sum | cut -d' ' -f1)"
    printf \
    '{"args":["%s"],"target_arg":null,"version":"1.0.4","protocol_version":1,"cwd":"%s"}\n' \
    "$1" \
    "$PWD" \
    | ${pkgs.socat}/bin/socat -lf /dev/null - UNIX-CONNECT:"$socket" \
    || "${qutebrowser}/bin/qutebrowser" -C ${./config.py} "$@" &
  '';
  qbDesktop = pkgs.makeDesktopItem {
    name = "qb";
    desktopName = "Qutebrowser";
    exec = "${qb}/bin/qb %u";
  };
in
lib.optionalAttrs (host ? hasScreen) {
  environment.systemPackages = [
    qb
    qbDesktop
    qutebrowser
  ];
}
