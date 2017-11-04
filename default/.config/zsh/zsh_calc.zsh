autoload -U zcalc

function __calc_plugin {
    zcalc -e "$*"
}

aliases[=]='noglob __calc_plugin'
