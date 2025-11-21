{ lib, functions, host, pkgs, ... }:
let
  python = pkgs.python3.withPackages (packages: (
    functions.readAttributes lib ./packages.txt packages
  ) ++ (lib.optionals (host ? hasCuda) (
    let
      gymnasium =
        packages.gymnasium.overridePythonAttrs {
          doCheck = false;
        };
    in
    [
      gymnasium
      (
        packages.ale-py.override {
          inherit gymnasium;
        }
      )
      packages.torchWithCuda
      (
        packages.einops.override {
          torch = packages.torchWithCuda;
        }
      )
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
  )));
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
