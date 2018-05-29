set disassembly-flavor intel

set print pretty
set print demangle on
set print asm-demangle on
set print frame-arguments all
set pagination off

set history filename /tmp/.gdb_history
set history save on
set history expansion on
set history size unlimited
set history remove-duplicates 1

set confirm off

shell if test -f "$HOME/.gdbinit.$HOST"; then echo source "$HOME/.gdbinit.$HOST"; fi > /tmp/gdbinit.tmp
source /tmp/gdbinit.tmp
