sudo loadkeys "$HOME/.config/linux-console/keymap"

if [[ $(tty) = "/dev/tty1" ]] ; then
    exec startx -- :0 vt1
fi
