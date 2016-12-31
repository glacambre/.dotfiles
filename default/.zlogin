sudo loadkeys /home/me/.keymap

if [[ $(tty) = "/dev/tty1" ]] ; then
    exec startx -- :0 vt$(tty | sed -e "s:/dev/tty::")
fi
