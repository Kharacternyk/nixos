{ lib, host, pkgs, readAttributes, ... }: {
  environment.etc."coc-settings.json".source = ./coc-settings.json;
  environment.systemPackages = [
    pkgs.rnix-lsp
    pkgs.typst-lsp
  ] ++ lib.optionals (host ? hasScreen) [
    pkgs.xsel
  ];
  environment.sessionVariables.EDITOR = "sudo -u nazar nvim";
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
    configure = {
      packages.myPlugins = {
        start = readAttributes ./plugins.txt pkgs.vimPlugins ++ [
          (pkgs.vimUtils.buildVimPlugin {
            name = "bullets";
            src = host.inputs.vim-bullets;
          })
          (pkgs.vimUtils.buildVimPlugin {
            name = "gruvbox";
            src = host.inputs.vim-gruvbox;
          })
          (pkgs.vimUtils.buildVimPlugin {
            name = "suda";
            src = host.inputs.vim-suda;
          })
          (pkgs.vimUtils.buildVimPlugin {
            name = "typst";
            src = host.inputs.vim-typst;
          })
        ];
      };
      customRC = builtins.readFile ./init.vim;
    };
  };
}
