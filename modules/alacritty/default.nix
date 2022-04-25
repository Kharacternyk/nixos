{ headless, pkgs, ... }: if headless then { } else {
  environment.systemPackages = with {
    term = pkgs.writeShellScriptBin "term" ''
      ${pkgs.alacritty}/bin/alacritty --config-file ${./alacritty.yaml} "$@"
    '';
  }; [
    pkgs.alacritty
    term
  ];
}
