#!/bin/zsh

ZSH_ILEUM_DIR="$ZDOTDIR/zsh-ileum"
ZSH_INTALL_FILE="/tmp/zsh_ileum_installation_error"
if [[ ! -d  "$ZSH_ILEUM_DIR" && ! -e "$ZSH_INSTALL_FILE" ]]; then
    echo "Trying to install zsh-ileum."
    mkdir -p "$(dirname "$ZSH_ILEUM_DIR")"
    git clone "https://github.com/glacambre/ileum.git" "$ZSH_ILEUM_DIR" > "$ZSH_INTALL_FILE"
    if [ "$?" != "0" ]; then
        echo "Failed to download zsh-ileum."
    fi
fi
if [[ -e "${ZSH_ILEUM_DIR}/ileum.sh" ]] ; then
    source "${ZSH_ILEUM_DIR}/ileum.sh"
fi
