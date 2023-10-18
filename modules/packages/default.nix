{ functions, pkgs, ... }: {
  environment.systemPackages = functions.readAttributes ./packages.txt pkgs;
}
