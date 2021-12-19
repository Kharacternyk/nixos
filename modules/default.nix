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
    ./qutebrowser
    ./texlive
    ./xserver
    ./zathura
  ];
  nixModule = { pkgs, ... }: {
    nix = {
      package = pkgs.nixUnstable;
      extraOptions = ''
        experimental-features = nix-command flakes
      '';
      registry.nixpkgs.flake = nixpkgs;
    };
    nixpkgs.config.allowUnfree = true;
  };
  machineModule = ../machines + "/${hostname}/configuration.nix";
in
commonModules ++ xserverModules ++ [ machineModule nixModule ]
