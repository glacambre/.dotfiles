set auto-load safe-path /
set disassembly-flavor intel

set print pretty
set print demangle on
set print asm-demangle on
set print frame-arguments all
set print object
set pagination off
set breakpoint pending on

shell if [ ! -d ~/.local/share/gdb ] ; then rm -rf ~/.local/share/gdb/history ; mkdir -p ~/.local/share/gdb ; fi
set history filename ~/.local/share/gdb/history
set history save on
set history expansion on
set history size unlimited
set history remove-duplicates 1

set confirm off

# winheight src 15

define rf
        reverse-finish
end

# Alert when long-running commands finish
define hook-run
        shell echo set \$RUNNING_SINCE=$(date '+%s') > /tmp/.gdb_time
end
define hook-continue
        shell echo set \$RUNNING_SINCE=$(date '+%s') > /tmp/.gdb_time
end
define hook-finish
        shell echo set \$RUNNING_SINCE=$(date '+%s') > /tmp/.gdb_time
end
define hook-next
        shell echo set \$RUNNING_SINCE=$(date '+%s') > /tmp/.gdb_time
end
define hook-step
        shell echo set \$RUNNING_SINCE=$(date '+%s') > /tmp/.gdb_time
end
define hook-stop
        shell echo set \$NOW=$(date '+%s') >> /tmp/.gdb_time
        with lang c -- source /tmp/.gdb_time
        if $NOW-$RUNNING_SINCE > 10
                shell notify-send "GDB" "Finished running command."
        end
end

# Firefox + RR: ignore sandbox signals
handle SIGSYS noprint nostop

# Disable security on everything. Hope I'll remember to remove this if I ever
# start debugging malicious software...
set auto-load safe-path /

shell if test -f "$HOME/.config/gdb/.gdbinit.$HOST"; then echo source "$HOME/.config/gdb/.gdbinit.$HOST"; fi > /tmp/gdbinit.tmp
source /tmp/gdbinit.tmp
