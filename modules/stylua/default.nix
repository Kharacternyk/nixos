{
  lib,
  pkgs,
  ...
}:
{
  environment.systemPackages =
    let
      stylua = pkgs.writeShellScriptBin "stylua" ''
        exec ${lib.getExe pkgs.stylua} -f ${./stylua.toml} "$@"
      '';
    in
    [
      stylua
    ];
}
