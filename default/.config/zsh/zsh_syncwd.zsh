#!/bin/zsh

ZSH_SYNCWD_DIR="$ZDOTDIR/zsh-syncwd"
ZSH_INTALL_FILE="/tmp/zsh_syncwd_installation_error"
if [[ ! -d  "$ZSH_SYNCWD_DIR" && ! -e "$ZSH_INSTALL_FILE" ]]; then
    echo "Trying to install zsh-syncwd."
    mkdir -p "$(dirname "$ZSH_SYNCWD_DIR")"
    git clone "https://github.com/glacambre/syncwd.git" "$ZSH_SYNCWD_DIR" > "$ZSH_INTALL_FILE"
    if [ "$?" != "0" ]; then
        echo "Failed to download zsh-syncwd."
    fi
fi
if [[ -e "${ZSH_SYNCWD_DIR}/syncwd.zsh" ]] ; then
    source "${ZSH_SYNCWD_DIR}/syncwd.zsh"
fi
