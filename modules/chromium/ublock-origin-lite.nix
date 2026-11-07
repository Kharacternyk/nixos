{
  lib,
  src,
  stdenvNoCC,
  writeText,
}:
let
  manifest = lib.importJSON "${src}/chromium/manifest.json";
  configuredManifest = writeText "ublock-origin-lite-manifest.json" (
    builtins.toJSON (
      manifest
      // {
        # Keep the extension ID and settings stable across Nix store paths.
        key = lib.trim (builtins.readFile ./ublock-origin-lite.pub);
      }
    )
  );
in
stdenvNoCC.mkDerivation {
  inherit (manifest) version;
  dontBuild = true;
  installPhase = ''
    runHook preInstall
    mkdir -p "$out/_metadata"
    cp -r . "$out/"
    runHook postInstall
  '';
  meta = {
    description = "A declarative content blocker for Chromium";
    homepage = "https://github.com/uBlockOrigin/uBOL-home";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.all;
  };
  pname = "ublock-origin-lite";
  postPatch = ''
    cp ${configuredManifest} manifest.json
  '';
  src = "${src}/chromium";
}
