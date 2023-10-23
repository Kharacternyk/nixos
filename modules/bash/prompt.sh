BOLD="$(tput bold)"
RED="$(tput setaf 1)"
CYAN="$(tput setaf 6)"
RESET="$(tput sgr0)"
PROMPT_COMMAND='
    if [[ $ECODE = 0 ]]; then
        PROMPT_COLOR="$BOLD$CYAN"
    else
        PROMPT_COLOR="$BOLD$RED"
    fi
    history -a
    history -n
'
PS1='\[$PROMPT_COLOR\]\$ \[$RESET\]'
PS2='\[$PROMPT_COLOR\]> \[$RESET\]'
