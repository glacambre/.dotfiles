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
