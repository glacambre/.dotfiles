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

function nvim_save_prompt () {
    # Note: if this breaks, try ${{(%)${(e)PS1}}}
    nvimsaveprompt "$$" "${(%e)PS1}"
}
# Apparently not needed
# (nvim_save_prompt &) >/dev/null
if [[ ! -v precmd_functions ]]; then
    precmd_functions=()
fi
precmd_functions+=nvim_save_prompt
