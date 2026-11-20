{
  host,
  lib,
  pkgs,
  ...
}:
lib.optionalAttrs (host ? hasScreen) {
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "term" ''
      if ! ${lib.getExe pkgs.alacritty} msg create-window "$@"; then
        ${lib.getExe pkgs.alacritty} --config-file ${./alacritty.toml} "$@"
      fi
    '')
  ];
}
