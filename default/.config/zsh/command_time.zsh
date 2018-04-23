
function display_command_time() {
    if [[ "$LAST_COMMAND_TIME" != "" ]]; then
        timespan="$(($(date '+%s') - $LAST_COMMAND_TIME))"
        if [[ "$timespan" -gt 120 ]]; then
            echo "Job took $timespan seconds."
        fi
    fi
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
