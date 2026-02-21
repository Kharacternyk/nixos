{ lib, functions, host, pkgs, ... }:
let
  python = pkgs.python3.withPackages (packages: (
    functions.readAttributes lib ./packages.txt packages
  ) ++ (if host ? hasCuda then
    (
      [
        packages.torchWithCuda
        (
          packages.pytorch-lightning.override {
            torch = packages.torchWithCuda;
          }
        )
        (
          packages.torchaudio.override {
            torch = packages.torchWithCuda;
          }
        )
        (
          packages.torchcodec.override {
            cudaSupport = true;
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
    packages.pytorch-lightning
    packages.torch
    packages.torchaudio
    packages.torchcodec
    packages.torchvision
  ]
  ) ++ (
    let
      synchronicity = packages.buildPythonPackage {
        pname = "synchronicity";
        version = "rolling";
        pyproject = true;
        src = host.inputs.synchronicity;
        build-system = [
          packages.hatchling
        ];
        dependencies = [
          packages.typing-extensions
        ];
      };
      modal = packages.buildPythonPackage {
        pname = "modal";
        version = "rolling";
        pyproject = true;
        src = host.inputs.modal;
        dontCheckRuntimeDeps = true;
        preBuild = ''
          patchShebangs protoc_plugin/plugin.py
          inv protoc
          inv type-stubs
        '';
        build-system = [
          (
            packages.setuptools.overridePythonAttrs {
              version = "77.0.3";
              src = host.inputs.setuptools-77;
            }
          )
          packages.grpcio-tools
          packages.grpclib
          packages.invoke
          packages.ipython
          packages.mypy-protobuf
          packages.ruff
          packages.sigtools
          synchronicity
        ];
        dependencies = [
          packages.aiohttp
          packages.cbor2
          packages.certifi
          packages.click
          packages.grpclib
          packages.protobuf
          packages.rich
          packages.toml
          packages.typer
          packages.types-toml
          packages.watchfiles
          synchronicity
        ];
      };
    in
    [
      modal
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
