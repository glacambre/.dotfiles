alias man='nvimman'

# automatically change working dir of parent buffer if using zsh within nvim
function nvim_cd () {
    emulate -L zsh
    nvimcd "$(pwd)"
}
(nvim_cd &) >/dev/null
if [[ ! -v chpwd_functions ]]; then
    chpwd_functions=()
fi
chpwd_functions+=nvim_cd

function nvim_save_prompt() {
    # Note: if this breaks, try ${{(%)${(e)PS1}}}
    nvimsaveprompt "$$" "${(%e)PS1}" "$1"
}
if [[ ! -v preexec_functions ]]; then
    preexec_functions=()
fi
preexec_functions+=nvim_save_prompt
