{ lib, fretwire, host, pkgs, ... }:
let
  packages = if host ? hasCuda then pkgs.pkgsCuda else pkgs;
  python = packages.python3.withPackages (packages: (
    fretwire.lib.import packages ./packages.few
  ) ++ (lib.optionals (host ? hasCuda) (
    let
      torchaudio = packages.torchaudio.overridePythonAttrs {
        doCheck = false;
      };
    in
    [
      torchaudio
      (
        packages.encodec.override {
          inherit torchaudio;
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
