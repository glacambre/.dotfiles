
export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"

function _gpg-agent-update-tty {
    gpg-connect-agent UPDATESTARTUPTTY /bye >/dev/null
}

if [[ ! -v preexec_functions ]]; then
    preexec_functions=()
fi
preexec_functions+=_gpg-agent-update-tty
