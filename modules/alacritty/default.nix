{ lib, host, pkgs, ... }: lib.optionalAttrs (host ? hasScreen) {
  environment.systemPackages =
    let
      alacritty = "${pkgs.alacritty}/bin/alacritty";
      term = pkgs.writeShellScriptBin "term" ''
        if ! ${alacritty} msg create-window "$@"; then
          ${alacritty} --config-file ${./alacritty.toml} "$@"
        fi
      '';
    in
    [
      pkgs.alacritty
      term
    ];
}
