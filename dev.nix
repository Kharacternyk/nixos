{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    clang-tools
    gdb
    valgrind
  ];
}
