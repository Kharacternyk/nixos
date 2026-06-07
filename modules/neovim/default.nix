{ lib, fretwire, host, pkgs, ... }: {
  environment = {
    sessionVariables.EDITOR = "sudo -u nazar nvim";
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
            "suda"
            "typst"
          ]
        ) ++ [
        fretwire.packages.${host.system}.vim
      ];
    };
    viAlias = true;
    vimAlias = true;
  };
}
