if [[ $(tty) = "/dev/tty1" ]] ; then
    if which pulseaudio >/dev/null 2>/dev/null ; then
        pulseaudio --start &
    fi
    # if running in the first tty, run startx
    if which startx >/dev/null 2>/dev/null ; then
        exec startx -- :0 vt1
    fi
else
    # if running in another tty/pty
    if [[ "$SSH_CONNECTION" == "" ]]
    then
        # if not running in an ssh connection (= we're in a tty), load custom
        # linux console keymap
        sudo loadkeys "$HOME/.config/linux-console/keymap"
    else
        which abduco >/dev/null
        if [[ $? == 0 ]]
        then
            # if running in ssh and abduco is available, run zsh within abduco
            exec abduco -A "$(date '+%s')" zsh
        fi
    fi
fi
