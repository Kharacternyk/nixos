{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    (polybar.override {
      alsaSupport = false;
      pulseSupport = true;
    })
  ];
  environment.etc = {
    "polybar.conf".source = ./polybar.conf;
  };
}
