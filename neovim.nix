{ pkgs, ... }: {
  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
  environment.systemPackages = with pkgs; [
    (neovim.override {
      viAlias = true;
      vimAlias = true;
      configure = {
        packages.myPlugins = with pkgs.vimPlugins; {
          start = [
            easymotion
            sleuth
            undotree
            vim-nix
            vimtex
            (pkgs.vimUtils.buildVimPlugin {
              name = "gruvbox";
              src = pkgs.fetchFromGitHub {
                owner = "gruvbox-community";
                repo = "gruvbox";
                rev = "master";
                sha256 = "18ng4qk4wi56bq64hc7sw3dx299cnjcg0zghk9r39dpi5fv68d8h";
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
    })
    neovim-remote
  ];
}
