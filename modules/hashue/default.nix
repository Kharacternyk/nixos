{ pkgs, ... }:
let hashue = pkgs.writers.writePython3Bin "hashue" { } (builtins.readFile ./hashue.py); in
{
  environment.systemPackages = [
    hashue
  ];
}
