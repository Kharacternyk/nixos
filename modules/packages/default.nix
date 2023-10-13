{ lib, functions, host, pkgs, ... }: {
  environment.systemPackages = functions.readAttributes ./default.txt pkgs
    ++ (lib.optionals (host ? hasScreen) (functions.readAttributes ./graphical.txt pkgs));
}
