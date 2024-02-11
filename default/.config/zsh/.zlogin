if [[ $(tty) = "/dev/tty1" ]] ; then
    # if running in the first tty, try running these daemons
    if command -v dbus-launch >/dev/null 2>/dev/null ; then
        if [ "$(pidof dbus-daemon)" = "" ] ; then
            export $(dbus-launch)
        fi
    fi
    if command -v sway >/dev/null 2>/dev/null; then
        # export WLR_DRM_DEVICES=/dev/dri/card1
        exec sway
    fi
    if command -v startx >/dev/null 2>/dev/null ; then
        exec startx -- :0 vt1
    fi
fi
