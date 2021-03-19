{ ... }: {
  environment.shellAliases = {
    sudo = "sudo ";
    ls = "ls --color=auto -FA";
    grep = "grep --color=auto";
    fgrep = "fgrep --color=auto";
    egrep = "egrep --color=auto";
    diff = "diff --color=auto";
    ncdu = "ncdu --color=dark";
    objdump = "objdump -M intel-mnemonic --visualize-jumps=color";
  };
  programs.bash.promptInit = ''
    BOLD="$(tput bold)"
    RED="$(tput setaf 1)"
    CYAN="$(tput setaf 6)"
    RESET="$(tput sgr0)"
    PROMPT_COMMAND='
        ECODE=$?
        PROMPT_COLOR="$BOLD$CYAN"
        [[ $ECODE != 0 ]] && PROMPT_COLOR="$BOLD$RED"
        history -a
        history -n
    '
    PS1='\[$PROMPT_COLOR\]\$ \[$RESET\]'
    PS2='\[$PROMPT_COLOR\]> \[$RESET\]'
  '';
  programs.bash.interactiveShellInit = builtins.readFile ./sources/bashrc;
}
