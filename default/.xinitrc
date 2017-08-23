FILENAME="$HOME/.xinitrc.$(hostname)"
if [ -e "$FILENAME" ] ; then
    source "$FILENAME"
fi

# Use a custom compose key
export GTK_IM_MODULE="xim"

# Make caps lock send hyper, make both shit press send caps lock
(setxkbmap -layout fr-latin9 -option caps:hyper -option shift:both_capslock &&
# Make a single hyper press send escape
xcape -e "Hyper_L=Escape") &

i3
