{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    bottom
    entr
    fzf
    killall
    man-pages
    mkpasswd
    ncdu
    neofetch
    nixpkgs-fmt
    nix-tree
    nodePackages.wrangler
    ripgrep
    unzip
    (
      let
        python-packages = packages: with packages; [
          black
          pygments
        ] ++ packages.black.optional-dependencies.d;
      in
      python3.withPackages python-packages
    )
  ];
  environment.variables = {
    FZF_DEFAULT_OPTS = ''
      --bind=change:top
      --prompt='/ '
      --info=hidden
      --color fg:-1,bg:-1,hl:1,fg+:-1,bg+:-1,hl+:1
      --color prompt:4,spinner:4,marker:4,pointer:4
      --reverse
    '';
    LESSHISTFILE = "/dev/null";
  };
}
