if [[ $(tty) = "/dev/tty1" ]] ; then
    # if running in the first tty, try running these daemons
    if which dbus-launch >/dev/null 2>/dev/null ; then
        export $(dbus-launch)
    fi
    if which pulseaudio >/dev/null 2>/dev/null ; then
        pulseaudio --start &
    fi
    if which sway >/dev/null 2>/dev/null; then
        exec sway
    fi
    if which startx >/dev/null 2>/dev/null ; then
        exec startx -- :0 vt1
    fi
else
    # if running in another tty/pty
    if [[ "$SSH_CONNECTION" == "" ]] ; then
        # if not running in an ssh connection (= we're in a tty), load custom
        # linux console keymap
        cmd="sudo loadkeys '$HOME/.config/linux-console/keymap'"
        echo $cmd
        eval $cmd
    fi
fi
