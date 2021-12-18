{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    alacritty
  ];
  environment.etc = {
    "alacritty.yaml".source = ./alacritty.yaml;
  };
}
