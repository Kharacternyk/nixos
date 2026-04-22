BOLD="$(tput bold)"
RED="$(tput setaf 1)"
GREEN="$(tput setaf 2)"
MAGENTA="$(tput setaf 5)"
CYAN="$(tput setaf 6)"
RESET="$(tput sgr0)"
PROMPT_COMMAND='
    if [[ $? = 0 ]]; then
        if [[ -z $lf ]]; then
            case $HOSTNAME in
                *server*) PROMPT_COLOR="$GREEN" ;;
                *) PROMPT_COLOR="$CYAN" ;;
            esac
        else
            PROMPT_COLOR="$MAGENTA"
        fi
    else
        PROMPT_COLOR="$RED"
    fi

    PROMPT_COLOR="$BOLD$PROMPT_COLOR"
    
    history -a
    history -n
'
PS1='\[$PROMPT_COLOR\]\$ \[$RESET\]'
PS2='\[$PROMPT_COLOR\]> \[$RESET\]'
