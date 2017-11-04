export fpath=("$ZDOTDIR/completion" $fpath)
autoload -Uz compinit promptinit
compinit -d /tmp/zcompdump.me
promptinit
[ -e "/etc/gentoo-release" ] && prompt gentoo
zstyle ':completion:*:*:*:*:*' menu select

zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path /tmp
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

setopt auto_list         # When requesting autocomp ambiguously, show list of options on first request
setopt auto_menu         # When autocompleting ambiguously, insert first match on second autocomp request
setopt auto_remove_slash # When the last autocompleted char is a slash and a space is typed next, remove the slash
setopt complete_aliases  # Complete aliases instead of expanding them
setopt complete_in_word  # When autocompleting, cursor should stay at pos instead of going to end of word
setopt glob_complete     # When requesting autocomp for glob (.e.g. *), don't replace with matches, instead offer autocomp
setopt list_ambiguous    # Don't show completion list when requesting unambiguous autocompletion
unsetopt list_beep       # Don't beep on ambiguous completion
setopt list_packed       # Make autocompletion columns smaller
unsetopt list_rows_first # Don't sort autocompletion in rows (sort in columns)
setopt menu_complete     # When autocompleting, insert the whole first match directly
