#!/bin/zsh

ZSH_CALC_DIR="$ZSH_HOME/zsh-calc"
ZSH_INTALL_FILE="/tmp/zsh_calc_installation_error"
if [[ ! -d  "$ZSH_CALC_DIR" && ! -e "$ZSH_INSTALL_FILE" ]]; then
    echo "Trying to install zsh-calc."
    git clone "https://github.com/arzzen/calc.plugin.zsh" "$ZSH_CALC_DIR" > "$ZSH_INTALL_FILE"
    if [ "$?" != "0" ]; then
        echo "Failed to download zsh-calc."
    fi
fi
if [[ -e "${ZSH_CALC_DIR}/calc.plugin.zsh" ]] ; then
    source "${ZSH_CALC_DIR}/calc.plugin.zsh"
fi
