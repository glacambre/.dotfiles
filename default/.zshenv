export ZDOTDIR="$HOME/.config/zsh/"

##### MISC VARIABLES
export PATH="$PATH:/usr/bin:/usr/sbin:/bin:/sbin"
export PATH="$HOME/e3/bin:$PATH"
export PATH="$HOME/wave/x86_64-linux/gdb/install/bin:$PATH"

export SYSTEMD_EDITOR="vi"
export EDITOR="nvim"
export GIMP2_DIRECTORY="$HOME/.config/gimp-2.8"
export NODE_REPL_HISTORY=""
export VISUAL="$EDITOR"
export XDG_CONFIG_HOME="$HOME/.config/"
export XDG_DATA_HOME="$HOME/.local/share/"
export DEBUGINFOD_URLS="https://debuginfod.debian.net"

##### LESS VARIABLES
# Don't create a .lesshst file
export LESSHISTFILE="-"
# Disable a few useless features
export LESSSECURE=1
# Set default command line options
export LESS="--ignore-case --SILENT -R"

##### LS_COLORS
LS_COLORS='';
LS_COLORS="${LS_COLORS}:no=00"    # normal text
LS_COLORS="${LS_COLORS}:fi=00"    # regular file
LS_COLORS="${LS_COLORS}:di=01;34" # directory
LS_COLORS="${LS_COLORS}:ex=01;32" # executable file
LS_COLORS="${LS_COLORS}:ln=01;36" # symlink
LS_COLORS="${LS_COLORS}:or=40;31" # orphaned link
LS_COLORS="${LS_COLORS}:pi=40;33" # named pipe
LS_COLORS="${LS_COLORS}:so=01;35" # socket
LS_COLORS="${LS_COLORS}:bd=33;01" # block device
LS_COLORS="${LS_COLORS}:cd=33;01" # character device
export LS_COLORS="$LS_COLORS"
export ZLS_COLORS="$LS_COLORS"
