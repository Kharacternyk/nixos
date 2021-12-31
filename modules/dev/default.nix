{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
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
