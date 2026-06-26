
PS1=""
if [[ "$USER" != 'me' ]] && [[ "$USER" != 'lacambre' ]]; then
    PS1="%n"
fi

# Needed to check for both ssh and recursion
parentprocess="$(ps -o comm= -p $PPID)"

if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    PS1="%n@%M"
else
    case "$parentprocess" in
        sshd|*/sshd) PS1="%n@%M" ;;
    esac
fi

# Only use an angle bracket as PS1 if not running in nvim, as neovim delineates
# prompt markers on its own
if [ "$NVIM" = "" ]; then
    PS1="$PS1>"
fi

# Add semantic prompts
PS1=$'%{\e]133;A\a%}'$PS1$'%{\e]133;B\a%}'
