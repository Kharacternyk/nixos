{ host, pkgs, ... }: {
  environment.etc."coc-settings.json".source = ./coc-settings.json;
  environment.systemPackages = with pkgs; [
    rnix-lsp
    typst-lsp
  ];
  environment.sessionVariables.EDITOR = "sudo -u nazar nvim";
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
    configure = {
      packages.myPlugins = with pkgs.vimPlugins; {
        start = [
          coc-clangd
          coc-css
          coc-flutter
          coc-html
          coc-nvim
          coc-prettier
          coc-pyright
          coc-tsserver
          coc-vimtex
          sleuth
          undotree
          vim-jsx-pretty
          vim-markdown
          vim-nix
          vimtex
          plantuml-syntax
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
