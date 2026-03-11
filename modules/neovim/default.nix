{ lib, functions, host, pkgs, ... }: {
  environment = {
    sessionVariables.EDITOR = "sudo -u nazar nvim";
    systemPackages = functions.readAttributes lib ./packages.txt pkgs ++ (
      lib.optionals (host ? hasScreen) [
        pkgs.xsel
      ]
    );
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
            "conform"
            "gruvbox"
            "suda"
            "typst"
          ]
        );
    };
    viAlias = true;
    vimAlias = true;
  };
}
