{ lib, functions, host, pkgs, ... }:
let
  python = pkgs.python3.withPackages (packages: (
    functions.readAttributes lib ./packages.txt packages
  ) ++ (if host ? hasCuda then
    (
      [
        packages.torchWithCuda
        (
          packages.torchmetrics.override {
            torch = packages.torchWithCuda;
          }
        )
        (
          packages.torchvision.override {
            torch = packages.torchWithCuda;
          }
        )
      ]
    ) else [
    packages.torch
    packages.torchmetrics
    packages.torchvision
  ]
  ));
in
{
  environment = {
    systemPackages = [
      python
    ];
    variables = {
      PYTHON_BASIC_REPL = "1";
      UV_PYTHON = python;
      UV_PYTHON_PREFERENCE = "only-system";
    };
  };
}
