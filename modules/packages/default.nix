{ lib, functions, pkgs, ... }: {
  environment.systemPackages = functions.readAttributes lib ./packages.txt pkgs;
}
