{pkgs, ...}: {
    environment.variables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
    };
    environment.systemPackages = with pkgs; [
        (neovim.override {
            vimAlias = true;
            configure = {
                packages.myPlugins = with pkgs.vimPlugins; {
                    start = [
                        easymotion
                        ultisnips
                        vim-nix
                        vim-snippets
                        vimtex
                    ];
                };
                customRC = builtins.readFile ./sources/init.vim;
            };
        })
    ];
}
