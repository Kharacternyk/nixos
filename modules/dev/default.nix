{ pkgs, ... }: {
  virtualisation.docker.enable = true;
  environment.systemPackages = with pkgs; [
    awscli
    aws-sam-cli
    clang-tools
    fasm-bin
    gdb
    ghc
    nodejs
    poetry
    valgrind
  ];
  environment.variables = {
    ELECTRON_SKIP_BINARY_DOWNLOAD = "1";
  };
}
