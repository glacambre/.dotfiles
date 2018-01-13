#!/bin/zsh

ZSH_AUTOSUGGESTIONS_DIR="$ZDOTDIR/zsh-autosuggestions"
ZSH_INTALL_FILE="/tmp/zsh_autosuggestion_installation_error"
if [[ ! -d  "$ZSH_AUTOSUGGESTIONS_DIR" && ! -e "$ZSH_INSTALL_FILE" ]]; then
    echo "Trying to install zsh-autosuggestions."
    git clone "https://github.com/zsh-users/zsh-autosuggestions" "$ZSH_AUTOSUGGESTIONS_DIR" > "$ZSH_INTALL_FILE"
    if [ "$?" != "0" ]; then
        echo "Failed to download zsh-autosuggestions."
    fi
fi
if [[ -e "${ZSH_AUTOSUGGESTIONS_DIR}/zsh-autosuggestions.zsh" ]] ; then
    source "${ZSH_AUTOSUGGESTIONS_DIR}/zsh-autosuggestions.zsh"
    ZSH_AUTOSUGGEST_IGNORE_WIDGETS=(orig-\* beep run-help set-local-history which-command yank)
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=7'
    ZSH_AUTOSUGGEST_STRATEGY=match_prev_cmd
    bindkey -M viins '\t' autosuggest-accept
    bindkey -M viins '^[[Z' autosuggest-clear
fi
