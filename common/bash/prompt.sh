BOLD="$(tput bold)"
RED="$(tput setaf 1)"
CYAN="$(tput setaf 6)"
MAGENTA="$(tput setaf 5)"
RESET="$(tput sgr0)"
PROMPT_COMMAND='
    ECODE=$?
    PROMPT_COLOR="$BOLD$CYAN"
    [[ -n $NIX_SHELL ]] && PROMPT_COLOR="$BOLD$MAGENTA"
    [[ $ECODE != 0 ]] && PROMPT_COLOR="$BOLD$RED"
    history -a
    history -n
'
PS1='\[$PROMPT_COLOR\]\$ \[$RESET\]'
PS2='\[$PROMPT_COLOR\]> \[$RESET\]'
