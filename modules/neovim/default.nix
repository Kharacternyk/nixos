{ lib, functions, host, pkgs, ... }: {
  environment = {
    etc."coc-settings.json".source = ./coc-settings.json;
    sessionVariables.EDITOR = "sudo -u nazar nvim";
    systemPackages = [
      pkgs.nixd
      pkgs.typst-lsp
      host.inputs.typstfmt.packages.${pkgs.system}.default
    ] ++ lib.optionals (host ? hasScreen) [
      pkgs.xsel
    ];
  };
  programs.neovim = {
    enable = true;
    configure = {
      customRC = builtins.readFile ./init.vim;
      packages.plugins.start = functions.readAttributes lib ./plugins.txt pkgs.vimPlugins ++
        (
          let
            buildPlugin = name: pkgs.vimUtils.buildVimPlugin {
              inherit name;
              src = host.inputs."vim-${name}";
            };
          in
          map buildPlugin [
            "bullets"
            "gruvbox"
            "suda"
            "typst"
          ]
        );
    };
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
  };
}
