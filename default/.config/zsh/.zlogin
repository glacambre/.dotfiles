if [[ $(tty) = "/dev/tty1" ]] ; then
    # if running in the first tty, run startx
    exec startx -- :0 vt1
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
