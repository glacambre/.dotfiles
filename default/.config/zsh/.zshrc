##### ZSH MODULES
zmodload zsh/complete # Basic completion code
zmodload zsh/complist # Completion listing extension
zmodload zsh/zpty     # Enables starting commands in pseudo terminals

##### PATH
# This is here instead of zshenv because I'm overriding default binaries.
# I don't want binaries to be overriden in scripts and while zshenv is sourced
# for scripts, zshrc isn't.
export PATH="$HOME/bin/:$HOME/.cargo/bin/:$PATH"

source "$ZDOTDIR/zsh_syntax_highlighting.zsh"
source "$ZDOTDIR/aliases.zsh"
source "$ZDOTDIR/completion.zsh"
source "$ZDOTDIR/hash_directories.zsh"
source "$ZDOTDIR/history.zsh"
source "$ZDOTDIR/ps1.zsh"
source "$ZDOTDIR/vi-mode-color-prompt.zsh"
source "$ZDOTDIR/vi-mode-x-paste.zsh"
source "$ZDOTDIR/vi-mode.zsh"
source "$ZDOTDIR/zsh_auto_suggestions.zsh"
if [ "$NVIM_LISTEN_ADDRESS" != "" ]
then
    source "$ZDOTDIR/nvim.zsh"
fi


### VARIOUS OPTIONS
setopt auto_cd                # Cd when a dirname has been given instead of a program
setopt auto_param_keys        # Remove automatically inserted chars (' ', ','...) when special chars are typed
setopt auto_param_slash       # When completing a dir name, add a trailing slash
setopt auto_pushd             # Cd pushes directories on the pushd stack
unsetopt beep                 # Don't beep. Ever.
unsetopt bg_nice              # Don't nice background jobs
setopt cdable_vars            # If dirname given to cd isn't a dir, try acting like a ~ is in front of it
setopt correct_all            # Try to correct typos in bin/dir names
unsetopt flow_control         # Disable scroll-lock in shell editor
setopt glob_dots              # Do not require a leading '.' in order to match files
setopt hash_cmds              # Hash command locations for faster invocations
setopt hash_dirs              # Hash directories containing invocked commands
setopt hash_list_all          # Hash completions/spelling corrections to go faster on second completion/correction
setopt hup                    # Send hup to running jobs when the shell exits
setopt interactive_comments   # Recognize comments as comments in the shell
unsetopt list_types           # Don't show a trailing character to show filetype (colors are enough)
setopt local_options          # Save options before fn exec and restore after
setopt local_traps            # Save traps before fn exec and restore after
setopt magic_equal_subst      # Perform expansion on ~ even when using --arg=~/blah
setopt mail_warning           # Warn if a mail file has been accessed since the shell last checked
setopt mark_dirs              # Append a / on dir names created from globbing
setopt monitor                # Allow job control
setopt multios                # Do implicit tee/cat when trying to redir output multiple times
unsetopt notify               # Wait for a new prompt to be displayed before printing jobs status
setopt numeric_glob_sort      # On {01..XX} expansions, sort numerically instead of lexicographically
setopt pushd_ignore_dups      # Don't duplicate directories in the pushd stack
setopt pushd_silent           # Don't print directory stack after pushd/popd
setopt short_loops            # Allow alternative syntax, e.g. if { true } { thing() } else { other() }
