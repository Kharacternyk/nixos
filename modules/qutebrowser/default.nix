{ host, lib, pkgs, qutebrowser-mypy, qutebrowser-patch, ... }:
let
  qutebrowser = pkgs.qutebrowser.overrideAttrs (attrs: {
    patches = attrs.patches ++ [
      qutebrowser-patch
    ];
    prePatch = ''
      cp ${qutebrowser-mypy} .mypy.ini
      chmod +w .mypy.ini
    '';
  });
  qb = pkgs.replaceVarsWith {
    dir = "bin";
    isExecutable = true;
    name = "qb";
    replacements = {
      config = "${./config.py}";
      python = "${pkgs.python3}/bin/python3";
      qutebrowser = "${qutebrowser}/bin/qutebrowser";
      version = qutebrowser.version;
    };
    src = ./qb.py;
  };
  qbDesktop = pkgs.makeDesktopItem {
    desktopName = "Qutebrowser";
    exec = "${qb}/bin/qb %u";
    name = "qb";
  };
in
lib.optionalAttrs (host ? hasScreen) {
  environment.systemPackages = [
    qb
    qbDesktop
    qutebrowser
  ];
}
