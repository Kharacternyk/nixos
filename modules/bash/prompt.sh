BOLD="$(tput bold)"
RED="$(tput setaf 1)"
GREEN="$(tput setaf 2)"
CYAN="$(tput setaf 6)"
RESET="$(tput sgr0)"
PROMPT_COMMAND='
    if [[ $? = 0 ]]; then
        case $HOSTNAME in
            *server*) PROMPT_COLOR="$BOLD$GREEN" ;;
            *) PROMPT_COLOR="$BOLD$CYAN" ;;
        esac
    else
        PROMPT_COLOR="$BOLD$RED"
    fi
    history -a
    history -n
'
PS1='\[$PROMPT_COLOR\]\$ \[$RESET\]'
PS2='\[$PROMPT_COLOR\]> \[$RESET\]'
