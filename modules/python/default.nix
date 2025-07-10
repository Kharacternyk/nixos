{ lib, functions, host, pkgs, ... }:
let
  python = pkgs.python3.withPackages (packages: (
    functions.readAttributes lib ./packages.txt packages
  ) ++ (lib.optionals (host ? hasCuda) [
    packages.torchWithCuda
    (
      packages.torchvision.override {
        torch = packages.torchWithCuda;
      }
    )
  ]));
in
{
  environment = {
    systemPackages = [
      python
    ];
    variables = {
      UV_PYTHON = python;
      UV_PYTHON_PREFERENCE = "only-system";
    };
  };
}
