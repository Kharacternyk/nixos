{ lib, functions, host, pkgs, ... }:
let
  packages = if host ? hasCuda then pkgs.pkgsCuda else pkgs;
  python = packages.python3.withPackages (packages: (
    functions.readAttributes lib ./packages.txt packages
  ) ++ [
    (
      packages.torchaudio.overridePythonAttrs {
        doCheck = false;
      }
    )
  ]);
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
