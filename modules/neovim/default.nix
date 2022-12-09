{ inputs, pkgs, ... }: {
  environment.etc."coc-settings.json".source = ./coc-settings.json;
  environment.systemPackages = with pkgs; [
    rnix-lsp
  ];
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    withNodeJs = true;
    configure = {
      packages.myPlugins = with pkgs.vimPlugins; {
        start = [
          coc-clangd
          coc-css
          coc-flutter
          coc-html
          coc-java
          coc-nvim
          coc-prettier
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
}
