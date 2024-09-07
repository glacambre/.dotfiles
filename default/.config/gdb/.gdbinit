set debuginfod enabled on

python
import os
import subprocess
from datetime import datetime
end

source /home/lacambre/.dotfiles/default/.config/gdb/nvim.gdb/nvim.py
set auto-load safe-path /

set disassembly-flavor intel

set print elements 0
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
define set_running_since
python
running_since=datetime.now()
end
end
set_running_since
define hook-run
        set_running_since
end
define hook-continue
        set_running_since
end
define hook-finish
        set_running_since
end
define hook-next
        set_running_since
end
define hook-step
        set_running_since
end
define hook-stop
python
now=datetime.now()
if (now - running_since).seconds > 10:
        subprocess.run(["notify-send", "GDB", "Finished running command."])
end
end

# Firefox + RR: ignore sandbox signals
handle SIGSYS noprint nostop

# Disable security on everything. Hope I'll remember to remove this if I ever
# start debugging malicious software...
set auto-load safe-path /

define printwrite
python
print(gdb.parse_and_eval("(char*)buf").string(length=int(gdb.parse_and_eval("nbytes"))))
end

shell if test -f "$HOME/.config/gdb/.gdbinit.$HOST"; then echo source "$HOME/.config/gdb/.gdbinit.$HOST"; fi > /tmp/gdbinit.tmp
source /tmp/gdbinit.tmp
