{
  fretwire,
  host,
  lib,
  nixpkgs-cuda,
  pkgs,
  system,
  ...
}:
let
  packages =
    if host ? hasCuda then
      import nixpkgs-cuda {
        inherit system;
        config = {
          allowUnfree = true;
          cudaSupport = true;
        };
      }
    else
      pkgs;
  python = packages.python3.withPackages (
    packages:
    fretwire.lib.import packages ./packages.few
    ++ lib.optionals (host ? hasCuda) (
      let
        torchaudio = packages.torchaudio.overridePythonAttrs {
          doCheck = false;
        };
      in
      [
        (packages.encodec.override {
          inherit torchaudio;
        })
        torchaudio
      ]
    )
  );
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
