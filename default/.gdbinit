set disassembly-flavor intel

set print pretty
set print demangle on
set print asm-demangle on
set print frame-arguments all
set pagination off

shell if [ ! -d ~/.local/share/gdb ] ; then rm -rf ~/.local/share/gdb/history ; mkdir -p ~/.local/share/gdb ; fi
set history filename ~/.local/share/gdb/history
set history save on
set history expansion on
set history size unlimited
set history remove-duplicates 1

set confirm off

winheight src 15

shell if test -f "$HOME/.gdbinit.$HOST"; then echo source "$HOME/.gdbinit.$HOST"; fi > /tmp/gdbinit.tmp
source /tmp/gdbinit.tmp
