# We need this to dynamically add user to prompt
setopt PROMPT_SUBST
PS1='}$([ "$USER" != "me" ] && echo $USER)'
parentprocess="$(ps -o comm= -p $PPID)"
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    PS1="}%n@%M"
else
    case "$parentprocess" in
        sshd|*/sshd) PS1="}%n@%M" ;;
    esac
fi
case "$parentprocess" in
    *sh) PS1="$PS1% ∞" ;;
esac
export PS1="$PS1%~{"
