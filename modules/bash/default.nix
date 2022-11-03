{
  environment.shellAliases = {
    sudo = "sudo ";
    btm = "btm --color=default-light";
    ls = "ls --color=auto -FA";
    grep = "grep --color=auto";
    fgrep = "fgrep --color=auto";
    egrep = "egrep --color=auto";
    diff = "diff --color=auto";
    ncdu = "ncdu --color=dark";
    objdump = "objdump -M intel-mnemonic --visualize-jumps=color";
  };
  environment.etc = {
    inputrc.source = ./inputrc;
  };
  programs.bash.promptInit = builtins.readFile ./prompt.sh;
  programs.bash.interactiveShellInit = builtins.readFile ./bashrc;
}
