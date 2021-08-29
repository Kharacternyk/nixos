{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    configure = {
      packages.myPlugins = with pkgs.vimPlugins; {
        start = [
          easymotion
          sleuth
          undotree
          vim-jsx-pretty
          vim-nix
          vimtex
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
              rev = "master";
              sha256 = "0y509alsjky51z6yzijfjh13lmj2na16wvwayzvf5nc19ls6adxk";
            };
          })
          (pkgs.vimUtils.buildVimPlugin {
            name = "jinja2-syntax";
            src = pkgs.fetchFromGitHub {
              owner = "Glench";
              repo = "Vim-Jinja2-Syntax";
              rev = "master";
              sha256 = "13mfzsw3kr3r826wkpd3jhh1sy2j10hlj1bv8n8r01hpbngikfg7";
            };
          })
          (pkgs.vimUtils.buildVimPlugin {
            name = "suda";
            src = pkgs.fetchFromGitHub {
              owner = "lambdalisue";
              repo = "suda.vim";
              rev = "v0.3.0";
              sha256 = "01kys8q3gycxqf760ydq1k8wq20brjvl1gxpl8j87jvnyx87kmnf";
            };
          })
        ];
      };
      customRC = builtins.readFile ./sources/init.vim;
    };
  };
}
