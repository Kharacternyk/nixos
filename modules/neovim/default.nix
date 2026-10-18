{ lib, fretwire, host, pkgs, ... }: {
  environment = {
    sessionVariables.EDITOR =
      let
        package = pkgs.writeShellScriptBin "editor" ''
          [[ $EUID == 1000 ]] && exec nvim "$@" || exit 22
        '';
      in
      "${package}/bin/editor";
    systemPackages = fretwire.lib.import pkgs ./packages.few ++ (
      lib.optionals (host ? hasScreen) [
        pkgs.xsel
      ]
    ) ++ [
      fretwire.packages.${host.system}.default
    ];
  };
  programs.neovim = {
    enable = true;
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
        fretwire.packages.${host.system}.vim
      ];
    };
    vimAlias = true;
  };
}
