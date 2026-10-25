{
  host,
  lib,
  ocenaudio,
  pkgs,
  ...
}:
lib.optionalAttrs (host ? hasScreen) {
  environment.systemPackages = [
    (pkgs.ocenaudio.overrideAttrs (oldAttrs: {
      autoPatchelfIgnoreMissingDeps = [ ];
      buildInputs = oldAttrs.buildInputs ++ [
        pkgs.libxcrypt-legacy
      ];
      preInstall = ''
        # The nixpkgs install phase replaces this with its own bzip2 library.
        rm -f opt/ocenaudio/lib/libbz2.so.1.0
      '';
      src = builtins.path {
        name = "ocenaudio.deb";
        path = ocenaudio.outPath;
      };
      version = "latest";
    }))
  ];
}
