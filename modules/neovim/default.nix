{
  fretwire,
  host,
  lib,
  pkgs,
  system,
  ...
}:
{
  environment = {
    sessionVariables.EDITOR =
      let
        package = pkgs.writeScriptBin "editor" ''
          #!${lib.getExe pkgs.bash} -p

          [[ $UID == 1000 && $EUID == 1000 ]] || exit 22

          permitted=
          while read -r key value _; do
            if [[ $key == CapPrm: ]]; then
              permitted="$value"
              break
            fi
          done < /proc/self/status

          [[ $permitted =~ ^0+$ ]] || exit 22

          exec /run/current-system/sw/bin/nvim "$@"
        '';
      in
      lib.getExe package;
    systemPackages =
      fretwire.lib.import pkgs ./packages.few
      ++ lib.optionals (host ? hasScreen) [
        pkgs.xsel
      ]
      ++ [
        fretwire.packages.${system}.default
      ];
  };
  programs.neovim = {
    configure = {
      customLuaRC = builtins.readFile ./init.lua;
      customRC = builtins.readFile ./init.vim;
      packages.plugins.start =
        fretwire.lib.import pkgs.vimPlugins ./plugins.few
        ++ lib.pipe host.inputs [
          (lib.filterAttrs (name: _: lib.hasPrefix "vim-" name))
          (lib.mapAttrsToList (
            name: src:
            pkgs.vimUtils.buildVimPlugin {
              inherit name src;
            }
          ))
        ]
        ++ [
          fretwire.packages.${system}.vim
        ];
    };
    enable = true;
    vimAlias = true;
  };
}
