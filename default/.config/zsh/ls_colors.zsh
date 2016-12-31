LS_COLORS='';
LS_COLORS="${LS_COLORS}:no=00"    # normal text
LS_COLORS="${LS_COLORS}:fi=00"	# regular file
LS_COLORS="${LS_COLORS}:di=01;34" # directory
LS_COLORS="${LS_COLORS}:ex=01;32" # executable file
LS_COLORS="${LS_COLORS}:ln=01;36" # symlink
LS_COLORS="${LS_COLORS}:or=40;31" # orphaned link
LS_COLORS="${LS_COLORS}:pi=40;33" # named pipe
LS_COLORS="${LS_COLORS}:so=01;35" # socket
LS_COLORS="${LS_COLORS}:bd=33;01" # block device
LS_COLORS="${LS_COLORS}:cd=33;01" # character device
export LS_COLORS="$LS_COLORS"
export ZLS_COLORS="$LS_COLORS"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
