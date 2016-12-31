HISTFILE="$ZSH_HOME/zsh_history"
HISTSIZE=1000000
SAVEHIST=1000000

unsetopt hist_beep            # Don't beep when a widget tries to access an history entry which isn't there.
setopt hist_expire_dups_first # If history contains dups, remove them first
setopt hist_fcntl_lock        # Use the OS's locking mechanism instead of ZSH's
setopt hist_find_no_dups      # When searching in the history do not show dups multiple times
setopt hist_ignore_all_dups   # When a new command which is a dup of another is added to the history, remove old dup
setopt hist_ignore_space      # Don't store lines that begin with a space in the history
setopt hist_no_store          # Don't add the "history" command to the history when it's called
setopt hist_reduce_blanks     # Don't store blank lines in the history
setopt inc_append_history     # Add commands to history ASAP, don't wait for shell exit
