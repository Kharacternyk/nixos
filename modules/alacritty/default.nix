{
  host,
  lib,
  pkgs,
  ...
}:
lib.optionalAttrs (host ? hasScreen) {
  environment.systemPackages =
    let
      inherit (pkgs) alacritty;
      term = pkgs.writeShellScriptBin "term" ''
        if ! ${lib.getExe alacritty} msg create-window "$@"; then
          ${lib.getExe alacritty} --config-file ${./alacritty.toml} "$@"
        fi
      '';
    in
    [
      alacritty
      term
    ];
}
