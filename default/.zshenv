export ZDOTDIR="$HOME/.config/zsh/"

##### MISC VARIABLES
export EDITOR="nvim"
export GIMP2_DIRECTORY="$HOME/.config/gimp-2.8"
export GREP_COLORS="mt=01;35:fn=34:ln=01;37:se=37"
export INDENT_PROFILE="$HOME/.config/indent/profile"
export NODE_REPL_HISTORY=""
export VISUAL="$EDITOR"
export XDG_DATA_HOME="$HOME/.local/share/"
export XKB_DEFAULT_LAYOUT="fr-latin9"

##### LESS VARIABLES
# Standout
export LESS_TERMCAP_so=$'\E[01;35;5;74m'
export LESS_TERMCAP_se=$'\E[0m'
# Underline
export LESS_TERMCAP_us=$'\E[03;135;5;146m'
export LESS_TERMCAP_ue=$'\E[0m'
# Make blink
export LESS_TERMCAP_mb=$'\E[01;31m'
# Make bold
export LESS_TERMCAP_md=$'\E[01;38;5;74m'
# Turn off bold, blink, underline
export LESS_TERMCAP_me=$'\E[0m'
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

