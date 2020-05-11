# Color PS1
KEYTIMEOUT=20
_PS1="$PS1"

if [[ "$TERM" != "linux" ]]; then
    PRINTCHAR="q"
fi

set_insert_colors() {
    # 148 is ^Z
    if [[ $__prompt_status == 0 ]] || [[ $__prompt_status == 148 ]]; then
        PS1="%{[0m%}$_PS1%{[0m%}"
    else
        PS1="%{[31m%}$_PS1%{[0m%}"
    fi
    print -n -- "\033[6 $PRINTCHAR"
}

zle-keymap-select() {
    if [[ "$KEYMAP" = "vicmd" ]] ; then
        # Green, block cursor
        PS1="%{[32m%}$_PS1%{[0m%}"
        print -n -- "\033[2 $PRINTCHAR"
    else
        set_insert_colors
    fi
    zle reset-prompt
}

precmd_setup_colors() {
    typeset -g __prompt_status="$?"
    set_insert_colors
}

if [ -z "$precmd_functions" ]; then
    precmd_functions=()
fi
precmd_functions+=precmd_setup_colors

zle -N zle-keymap-select
