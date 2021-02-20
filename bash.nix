{...}: {
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
        PROMPT_COMMAND='
        ECODE=$?
        PROMPT_COLOR=6
        [[ -n $VIRTUAL_ENV ]] && PROMPT_COLOR=2
        [[ $ECODE != 0 ]] && PROMPT_COLOR=1
        history -a
        history -n'

        PS1='\[$(tput setaf $PROMPT_COLOR)\]█◤\[$(tput sgr0)\]'
        PS2='\[$(tput setaf $PROMPT_COLOR)\]█ \[$(tput sgr0)\]'
    '';
    programs.bash.interactiveShellInit = builtins.readFile ./sources/bashrc;
    programs.bash.vteIntegration = true;
}
