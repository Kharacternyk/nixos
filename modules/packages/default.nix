{ lib, fretwire, pkgs, ... }: {
  environment.systemPackages = fretwire.lib.import pkgs ./packages.few;
}
