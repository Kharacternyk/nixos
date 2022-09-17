{ headless, gpu, pkgs, ... }: if headless then { } else {
  environment.systemPackages = with pkgs; [
    (polybar.override {
      alsaSupport = false;
      pulseSupport = true;
    })
  ];
  environment.etc = {
    "polybar.conf".text = builtins.readFile ./polybar.conf + (
      if gpu
      then ""
      else ''
        [settings]
        pseudo-transparency = true
      ''
    );
  };
}
