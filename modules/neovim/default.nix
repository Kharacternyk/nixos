{ fretwire, host, lib, pkgs, system, ... }: {
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
      "${package}/bin/editor";
    systemPackages = fretwire.lib.import pkgs ./packages.few ++ lib.optionals (host ? hasScreen) [
      pkgs.xsel
    ] ++ [
      fretwire.packages.${system}.default
    ];
  };
  programs.neovim = {
    configure = {
      customLuaRC = builtins.readFile ./init.lua;
      customRC = builtins.readFile ./init.vim;
      packages.plugins.start = fretwire.lib.import pkgs.vimPlugins ./plugins.few ++
        (
          let
            buildPlugin = name: pkgs.vimUtils.buildVimPlugin {
              inherit name;
              src = host.inputs."vim-${name}";
            };
          in
          map buildPlugin [
            "conform"
            "gruvbox"
            "typst"
          ]
        ) ++ [
        fretwire.packages.${system}.vim
      ];
    };
    enable = true;
    vimAlias = true;
  };
}
