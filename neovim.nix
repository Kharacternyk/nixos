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
                        sleuth
                        ultisnips
                        undotree
                        vim-cpp-enhanced-highlight
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
                        (pkgs.vimUtils.buildVimPlugin {
                            name = "python-syntax";
                            src = pkgs.fetchFromGitHub {
                                owner = "vim-python";
                                repo = "python-syntax";
                                rev = "master";
                                sha256 = "1w4yd25rnbhsps81agvq0kr3vcbif" +
                                         "rlpb7h4z0vcgsx1nvmxy205";
                            };
                        })
                    ];
                };
                customRC = (builtins.readFile ./sources/init.vim) +
                           (builtins.readFile ./sources/colors.vim);
            };
        })
        neovim-remote
    ];
}
