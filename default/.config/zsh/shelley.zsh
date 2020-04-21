#!/bin/zsh

ZSH_SHELLEY_DIR="$HOME/.config/nvim/pack/minpac/start/shelley"
ZSH_INSTALL_FILE="/tmp/zsh_shelley_installation_error"
if [[ ! -d  "$ZSH_SHELLEY_DIR" && ! -e "$ZSH_INSTALL_FILE" ]]; then
    echo "Trying to install zsh-shelley."
    mkdir -p "$(dirname "$ZSH_SHELLEY_DIR")"
    git clone "https://github.com/glacambre/shelley" "$ZSH_SHELLEY_DIR" > "$ZSH_INSTALL_FILE"
    if [ "$?" != "0" ]; then
        echo "Failed to download zsh-shelley."
    fi
fi
if [[ -e "${ZSH_SHELLEY_DIR}/shell/shelley.sh" ]] ; then
    source "${ZSH_SHELLEY_DIR}/shell/shelley.sh"
fi
