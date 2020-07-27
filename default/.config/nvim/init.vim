let s:config_dir = expand('<sfile>:p:h')
execute("source " . s:config_dir . "/functions.vim")
execute("source " . s:config_dir . "/settings.vim")
execute("source " . s:config_dir . "/keymap.vim")
execute("source " . s:config_dir . "/autocommands.vim")
execute("source " . s:config_dir . "/plugins.vim")
set rtp+=/home/me/prog/firenvim/

if exists('g:started_by_firenvim')
    nnoremap <C-CR> <Cmd>call firenvim#thunderbird_send()<CR>
    let g:firenvim_config = {
        \ 'localSettings': {
            \ 'riot.im': {
                \ 'takeover': 'never',
            \ },
            \ 'slack.com': {
                \ 'takeover': 'never',
            \ },
            \ 'git.adacore.com': {
                \ 'selector': '.com-google-gerrit-client-diff-DraftBox_BinderImpl_GenCss_style-editArea, .gwt-TextArea',
            \ },
            \ 'docs.google.com': {
                \ 'takeover': 'never',
            \ },
            \ 'airfrance.fr': {
                \ 'takeover': 'never',
            \ }
        \ }
    \ }
    nnoremap <Esc><Esc> :call firenvim#focus_page()<CR>
end
