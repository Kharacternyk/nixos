{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    configure = {
      packages.myPlugins = with pkgs.vimPlugins; {
        start = [
          coc-css
          coc-nvim
          coc-pyright
          coc-tsserver
          coc-vimtex
          easymotion
          haskell-vim
          sleuth
          undotree
          vim-jsx-pretty
          vim-nix
          vimtex
          plantuml-syntax
          (pkgs.vimUtils.buildVimPlugin {
            name = "bullets";
            src = pkgs.fetchFromGitHub {
              owner = "dkarter";
              repo = "bullets.vim";
              rev = "1.8.0";
              sha256 = "1gvv2ixq5qnxc546pr9qpn3z6h745q62aqf8rsavv5dvqajv68pp";
            };
          })
          (pkgs.vimUtils.buildVimPlugin {
            name = "gruvbox";
            src = pkgs.fetchFromGitHub {
              owner = "gruvbox-community";
              repo = "gruvbox";
              rev = "1f8500f033813fcc6f41f0fe366e27faa163f2c2";
              sha256 = "RcgxyRVK+fllhW6wCcTouSzfHRWjmYtnmdvM2okRdM8=";
            };
          })
          (pkgs.vimUtils.buildVimPlugin {
            name = "suda";
            src = pkgs.fetchFromGitHub {
              owner = "lambdalisue";
              repo = "suda.vim";
              rev = "v0.3.2";
              sha256 = "YfOYDHq9osVcujxY2Of7oYWNAw3RLf48nc9ys77rilg=";
            };
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
