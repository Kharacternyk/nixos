{ inputs, pkgs, ... }: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    configure = {
      packages.myPlugins = with pkgs.vimPlugins; {
        start = [
          coc-clangd
          coc-css
          coc-flutter
          coc-java
          coc-nvim
          coc-pyright
          coc-tsserver
          coc-vimtex
          easymotion
          haskell-vim
          sleuth
          undotree
          vim-jsx-pretty
          vim-markdown
          vim-nix
          vimtex
          plantuml-syntax
          (pkgs.vimUtils.buildVimPlugin {
            name = "bullets";
            src = inputs.vim-bullets;
          })
          (pkgs.vimUtils.buildVimPlugin {
            name = "gruvbox";
            src = inputs.vim-gruvbox;
          })
          (pkgs.vimUtils.buildVimPlugin {
            name = "suda";
            src = inputs.vim-suda;
          })
        ];
      };
      customRC = builtins.readFile ./init.vim;
    };
  };
  environment.etc = {
    inputrc.source = ./inputrc;
  };
}
