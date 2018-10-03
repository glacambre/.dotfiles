
function display_command_time() {
    cmd="$(history | tail -n 1 | cut -d' ' -f2-)"
    if [[ "$LAST_COMMAND_TIME" != "" ]]; then
        timespan="$(($(date '+%s') - $LAST_COMMAND_TIME))"
        if [[ "$timespan" -gt 120 ]]; then
            echo "Job took $timespan seconds."
            if which notify-send >/dev/null && which dunst >/dev/null; then
                notify="timeout 3 notify-send 'Command finished in $timespan seconds' '$cmd'"
                (
                if ! $(eval "$notify") ; then
                    dunst &
                    sleep 1
                    eval $notify
                fi
                ) 2>/dev/null >/dev/null &|
            fi
        fi
    fi
    LAST_COMMAND_TIME=""
}
if [ -z "$precmd_functions" ]; then
    precmd_functions=()
fi
precmd_functions+=display_command_time

function get_command_time() {
    export LAST_COMMAND_TIME="$(date '+%s')"
}
if [ -z "$preexec_functions" ]; then
    preexec_functions=()
fi
preexec_functions+=get_command_time
