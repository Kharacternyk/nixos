{pkgs, ...}: {
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
                        gruvbox-community
                        ultisnips
                        vim-nix
                        vim-snippets
                        vimtex
                        (pkgs.vimUtils.buildVimPlugin {
                            name = "suda";
                            src = pkgs.fetchFromGitHub {
                                owner = "lambdalisue";
                                repo = "suda.vim";
                                rev = "v0.3.0";
                                sha256 = "01kys8q3gycxqf760ydq1k8wq20br" +
                                         "jvl1gxpl8j87jvnyx87kmnf";
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
