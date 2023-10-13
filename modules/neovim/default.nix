{ lib, functions, host, pkgs, ... }: {
  environment = {
    etc."coc-settings.json".source = ./coc-settings.json;
    sessionVariables.EDITOR = "sudo -u nazar nvim";
    systemPackages = [
      pkgs.rnix-lsp
      pkgs.typst-lsp
    ] ++ lib.optionals (host ? hasScreen) [
      pkgs.xsel
    ];
  };
  programs.neovim = {
    enable = true;
    configure = {
      customRC = builtins.readFile ./init.vim;
      packages.plugins.start = functions.readAttributes ./plugins.txt pkgs.vimPlugins ++ [
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
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
  };
}
