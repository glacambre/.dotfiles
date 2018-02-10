#!/bin/zsh

ZSH_SYNTAX_HIGHLIGHTING_DIR="$ZDOTDIR/zsh-syntax-highlighting"
ZSH_INTALL_FILE="/tmp/zsh_syntax_highlighting_installation_error"
if [[ ! -d  "$ZSH_SYNTAX_HIGHLIGHTING_DIR" && ! -e "$ZSH_INSTALL_FILE" ]]; then
    echo "Trying to install zsh-syntax-highlighting."
    git clone "https://github.com/zsh-users/zsh-syntax-highlighting" "$ZSH_SYNTAX_HIGHLIGHTING_DIR" > "$ZSH_INTALL_FILE"
    if [ "$?" != "0" ]; then
        echo "Failed to download zsh-syntax-highlighting."
    fi
fi
if [[ -e "${ZSH_SYNTAX_HIGHLIGHTING_DIR}/zsh-syntax-highlighting.zsh" ]] ; then
    source "${ZSH_SYNTAX_HIGHLIGHTING_DIR}/zsh-syntax-highlighting.zsh"
    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
    # Main
    ZSH_HIGHLIGHT_STYLES[default]='none'
    ZSH_HIGHLIGHT_STYLES[reserved-word]="$ZSH_HIGHLIGHT_STYLES[default]"
    ZSH_HIGHLIGHT_STYLES[alias]='none'
    ZSH_HIGHLIGHT_STYLES[suffix-alias]="$ZSH_HIGHLIGHT_STYLES[alias]"
    ZSH_HIGHLIGHT_STYLES[builtin]="$ZSH_HIGHLIGHT_STYLES[alias]"
    ZSH_HIGHLIGHT_STYLES[function]="$ZSH_HIGHLIGHT_STYLES[alias]"
    ZSH_HIGHLIGHT_STYLES[command]="$ZSH_HIGHLIGHT_STYLES[alias]"
    ZSH_HIGHLIGHT_STYLES[precommand]="$ZSH_HIGHLIGHT_STYLES[alias]"
    ZSH_HIGHLIGHT_STYLES[commandseparator]="$ZSH_HIGHLIGHT_STYLES[reserved-word]"
    ZSH_HIGHLIGHT_STYLES[hashed-command]="$ZSH_HIGHLIGHT_STYLES[alias]"
    ZSH_HIGHLIGHT_STYLES[path]="$ZSH_HIGHLIGHT_STYLES[default]"
    ZSH_HIGHLIGHT_STYLES[path_separator]="$ZSH_HIGHLIGHT_STYLES[path]"
    ZSH_HIGHLIGHT_STYLES[path_prefix_separator]="$ZSH_HIGHLIGHT_STYLES[path]"
    ZSH_HIGHLIGHT_STYLES[globbing]="none"
    ZSH_HIGHLIGHT_STYLES[history-expansion]="$ZSH_HIGHLIGHT_STYLES[default]"
    ZSH_HIGHLIGHT_STYLES[single-hyphen-option]="$ZSH_HIGHLIGHT_STYLES[default]"
    ZSH_HIGHLIGHT_STYLES[double-hyphen-option]="$ZSH_HIGHLIGHT_STYLES[single-hyphen-option]"
    ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='none'
    ZSH_HIGHLIGHT_STYLES[back-quoted-argument-unclosed]='fg=1'
    ZSH_HIGHLIGHT_STYLES[single-quoted-argument]="$ZSH_HIGHLIGHT_STYLES[back-quoted-argument]"
    ZSH_HIGHLIGHT_STYLES[single-quoted-argument-unclosed]="$ZSH_HIGHLIGHT_STYLES[back-quoted-argument-unclosed]"
    ZSH_HIGHLIGHT_STYLES[double-quoted-argument]="$ZSH_HIGHLIGHT_STYLES[back-quoted-argument]"
    ZSH_HIGHLIGHT_STYLES[double-quoted-argument-unclosed]="$ZSH_HIGHLIGHT_STYLES[back-quoted-argument-unclosed]"
    ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]="$ZSH_HIGHLIGHT_STYLES[back-quoted-argument]"
    ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument-unclosed]="$ZSH_HIGHLIGHT_STYLES[back-quoted-argument-unclosed]"
    ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]="fg=6"
    ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]="$ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]"
    ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]="$ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]"


    # brackets
    ZSH_HIGHLIGHT_STYLES[bracket-error]='fg=1'
    ZSH_HIGHLIGHT_STYLES[bracket-level-1]='none'
    ZSH_HIGHLIGHT_STYLES[bracket-level-2]="$ZSH_HIGHLIGHT_STYLES[bracket-level-1]"
    ZSH_HIGHLIGHT_STYLES[bracket-level-3]="$ZSH_HIGHLIGHT_STYLES[bracket-level-1]"
    ZSH_HIGHLIGHT_STYLES[bracket-level-4]="$ZSH_HIGHLIGHT_STYLES[bracket-level-1]"
    ZSH_HIGHLIGHT_STYLES[bracket-level-5]="$ZSH_HIGHLIGHT_STYLES[bracket-level-1]"
    ZSH_HIGHLIGHT_STYLES[bracket-level-6]="$ZSH_HIGHLIGHT_STYLES[bracket-level-1]"
    ZSH_HIGHLIGHT_STYLES[bracket-level-7]="$ZSH_HIGHLIGHT_STYLES[bracket-level-1]"
    ZSH_HIGHLIGHT_STYLES[bracket-level-8]="$ZSH_HIGHLIGHT_STYLES[bracket-level-1]"
    ZSH_HIGHLIGHT_STYLES[bracket-level-9]="$ZSH_HIGHLIGHT_STYLES[bracket-level-1]"
fi
