nixpkgs: hostname: { headless ? false }:
let
  commonModules = [
    ./bash
    ./dev
    ./gc
    ./git
    ./nazar
    ./neovim
    ./lf
    ./locale
    ./utils
  ];
  xserverModules = if headless then [ ] else [
    ./alacritty
    ./bspwm
    ./fonts
    ./polybar
    ./qutebrowser
    ./texlive
    ./xserver
    ./zathura
  ];
  nixModule = { pkgs, ... }: {
    nix = {
      package = pkgs.nixFlakes;
      extraOptions = ''
        experimental-features = nix-command flakes
      '';
      registry.nixpkgs.flake = nixpkgs;
      nixPath = [ ];
    };
    nixpkgs.config.allowUnfree = true;
  };
  hostModule = ../hosts + "/${hostname}/configuration.nix";
in
commonModules ++ xserverModules ++ [ nixModule hostModule ]
