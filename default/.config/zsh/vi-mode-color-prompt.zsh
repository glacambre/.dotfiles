# Color PS1
export KEYTIMEOUT=10
export _PS1="$PS1"

precmd() {
    PS1="%{[38;05;4m%}$_PS1%{[0m%}"
}

print -n -- "\033[6 q"
zle-keymap-select() {
    if [[ "$KEYMAP" = "vicmd" ]] ; then
        # Green, block cursor
        PS1="%{[38;05;2m%}$_PS1%{[0m%}"
        print -n -- "\033[2 q"
    else
        # Blue, line cursor
        PS1="%{[38;05;4m%}$_PS1%{[0m%}"
        print -n -- "\033[6 q"
    fi
    () { return $__prompt_status }
    zle reset-prompt
}

zle-line-init() {
    typeset -g __prompt_status="$?"
}

zle -N zle-keymap-select
zle -N zle-line-init
