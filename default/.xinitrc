FILENAME="$HOME/.xinitrc.$(hostname)"
if [ -e "$FILENAME" ] ; then
    source "$FILENAME"
fi

# Use a custom compose key
export GTK_IM_MODULE="xim"

# Disable the X bell
# xset b off &

# Activate the numpad
# numlockx &

# Swap caps lock and escape
# setxkbmap -option caps:swapescape &

# Replace the right control key with the compose key
# setxkbmap -option compose:rctrl &

# Make caps lock send hyper, make both shit press send caps lock
(setxkbmap -layout fr-latin9 -option caps:hyper -option shift:both_capslock &&
# Make a single hyper press send escape
xcape -e "Hyper_L=Escape") &

# Start redshift with Paris as location
# redshift -l 48:2 &

# Merge X resources
xrdb -merge ~/.Xdefaults &

# Start i3
i3
