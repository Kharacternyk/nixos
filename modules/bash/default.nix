{
  environment = {
    shellAliases = {
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
    variables = {
      FZF_DEFAULT_OPTS = ''
        --bind=change:top
        --prompt='/ '
        --info=hidden
        --color fg:-1,bg:-1,hl:1,fg+:-1,bg+:-1,hl+:1
        --color prompt:4,spinner:4,marker:4,pointer:4
        --reverse
      '';
      LESSHISTFILE = "/dev/null";
    };
    etc.inputrc.source = ./inputrc;
  };
  programs.bash.promptInit = builtins.readFile ./prompt.sh;
  programs.bash.interactiveShellInit = builtins.readFile ./bashrc;
}
