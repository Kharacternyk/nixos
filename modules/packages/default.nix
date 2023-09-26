{ lib, host, pkgs, readAttributes, ... }: {
  environment.systemPackages = readAttributes ./default.txt pkgs
    ++ (lib.optionals (host ? hasScreen) (readAttributes ./graphical.txt pkgs));
}
