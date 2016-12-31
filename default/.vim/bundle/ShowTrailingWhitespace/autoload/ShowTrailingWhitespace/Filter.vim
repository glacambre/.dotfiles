" ShowTrailingWhitespace/Filter.vim: Exclude certain buffers from detection.
"
" DEPENDENCIES:
"
" Copyright: (C) 2012-2013 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
"   1.01.003	07-Oct-2013	Also exclude quickfix and help buffers from
"				detection.
"   1.00.002	06-Mar-2012	Modularize conditionals.
"				Also do not normally show 'binary' buffers.
"	001	05-Mar-2012	file creation

" Note: Could use ingo#buffer#IsPersisted(), but don't want to introduce a
" dependency to the ingo-library just for that.
function! s:IsPersistedBuffer()
    return (empty(&l:buftype) || &l:buftype ==# 'acwrite')
endfunction
function! s:IsScratchBuffer()
    return (bufname('') =~# '\[Scratch]')
endfunction
function! s:IsForcedShow()
    return (ShowTrailingWhitespace#IsSet() == 2)
endfunction

function! ShowTrailingWhitespace#Filter#Default()
    let l:isShownNormally = &l:modifiable && ! &l:binary && (s:IsPersistedBuffer() || s:IsScratchBuffer())
    return l:isShownNormally || s:IsForcedShow()
endfunction

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
