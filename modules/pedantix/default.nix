{ lib, pkgs, ... }: {
  environment.systemPackages =
    let
      inherit (lib) getExe;
      inherit (pkgs) nixfmt-rs;
      pedantix = pkgs.writeShellScriptBin "pedantix" ''
        exec ${getExe pkgs.pedantix} \
          --set formatter-command='["${getExe nixfmt-rs}", "--width=93", "-"]' \
          --config ${./pedantix.toml} "$@"
      '';
    in
    [
      nixfmt-rs
      pedantix
    ];
}
