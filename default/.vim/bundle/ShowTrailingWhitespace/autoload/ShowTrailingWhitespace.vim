" ShowTrailingWhitespace.vim: Detect unwanted whitespace at the end of lines.
"
" DEPENDENCIES:
"
" Copyright: (C) 2012-2015 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
"   1.02.006	30-Jan-2015	ENH: Keep previous (last accessed) window on
"				:windo.
"   1.02.005	22-Jul-2014	Make ShowTrailingWhitespace#IsSet() also handle
"				Vim 7.0/1 where the g:ShowTrailingWhitespace
"				variable is not set. Return 0 instead of causing
"				a function abort.
"   1.00.004	06-Mar-2012	Toggle to value 2 when enabled but the buffer is
"				filtered from showing trailing whitespace.
"	003	05-Mar-2012	Introduce g:ShowTrailingWhitespace_FilterFunc to
"				disable highlighting for non-persisted and
"				nomodifiable buffers.
"	002	02-Mar-2012	Introduce b:ShowTrailingWhitespace_ExtraPattern
"				to be able to avoid some matches (e.g. a <Space>
"				in column 1 in a buffer with filetype=diff) and
"				ShowTrailingWhitespace#SetLocalExtraPattern() to
"				set it.
"	001	25-Feb-2012	file creation
let s:save_cpo = &cpo
set cpo&vim

function! ShowTrailingWhitespace#Pattern( isInsertMode )
    return (exists('b:ShowTrailingWhitespace_ExtraPattern') ? b:ShowTrailingWhitespace_ExtraPattern : '') .
    \	(a:isInsertMode ? '\s\+\%#\@<!$' : '\s\+$')
endfunction
let s:HlGroupName = 'ShowTrailingWhitespace'
function! s:UpdateMatch( isInsertMode )
    let l:pattern = ShowTrailingWhitespace#Pattern(a:isInsertMode)
    if exists('w:ShowTrailingWhitespace_Match')
	" Info: matchadd() does not consider the 'magic' (it's always on),
	" 'ignorecase' and 'smartcase' settings.
	silent! call matchdelete(w:ShowTrailingWhitespace_Match)
	call matchadd(s:HlGroupName, pattern, -1, w:ShowTrailingWhitespace_Match)
    else
	let w:ShowTrailingWhitespace_Match =  matchadd(s:HlGroupName, pattern)
    endif
endfunction
function! s:DeleteMatch()
    if exists('w:ShowTrailingWhitespace_Match')
	silent! call matchdelete(w:ShowTrailingWhitespace_Match)
	unlet w:ShowTrailingWhitespace_Match
    endif
endfunction

function! s:DetectAll()
    " By entering a window, its height is potentially increased from 0 to 1 (the
    " minimum for the current window). To avoid any modification, save the window
    " sizes and restore them after visiting all windows.
    let l:originalWindowLayout = winrestcmd()
	let l:originalWinNr = winnr()
	let l:previousWinNr = winnr('#') ? winnr('#') : 1
	    noautocmd windo call ShowTrailingWhitespace#Detect(0)
	noautocmd execute l:previousWinNr . 'wincmd w'
	noautocmd execute l:originalWinNr . 'wincmd w'
    silent! execute l:originalWindowLayout
endfunction

function! ShowTrailingWhitespace#IsSet()
    return (exists('b:ShowTrailingWhitespace') ? b:ShowTrailingWhitespace : get(g:, 'ShowTrailingWhitespace', 0))
endfunction
function! ShowTrailingWhitespace#NotFiltered()
    let l:Filter = (exists('b:ShowTrailingWhitespace_FilterFunc') ? b:ShowTrailingWhitespace_FilterFunc : g:ShowTrailingWhitespace_FilterFunc)
    return (empty(l:Filter) ? 1 : call(l:Filter, []))
endfunction

function! ShowTrailingWhitespace#Detect( isInsertMode )
    if ShowTrailingWhitespace#IsSet() && ShowTrailingWhitespace#NotFiltered()
	call s:UpdateMatch(a:isInsertMode)
    else
	call s:DeleteMatch()
    endif
endfunction

" The showing of trailing whitespace be en-/disabled globally or only for a particular buffer.
function! ShowTrailingWhitespace#Set( isTurnOn, isGlobal )
    if a:isGlobal
	let g:ShowTrailingWhitespace = a:isTurnOn
	call s:DetectAll()
    else
	let b:ShowTrailingWhitespace = a:isTurnOn
	call ShowTrailingWhitespace#Detect(0)
    endif
endfunction
function! ShowTrailingWhitespace#Reset()
    unlet! b:ShowTrailingWhitespace
    call ShowTrailingWhitespace#Detect(0)
endfunction
function! ShowTrailingWhitespace#Toggle( isGlobal )
    if a:isGlobal
	let l:newState = ! g:ShowTrailingWhitespace
    else
	if ShowTrailingWhitespace#NotFiltered()
	    let l:newState = ! ShowTrailingWhitespace#IsSet()
	else
	    let l:newState = (ShowTrailingWhitespace#IsSet() > 1 ? 0 : 2)
	endif
    endif

    call ShowTrailingWhitespace#Set(l:newState, a:isGlobal)
endfunction

function! ShowTrailingWhitespace#SetLocalExtraPattern( pattern )
    let b:ShowTrailingWhitespace_ExtraPattern = a:pattern
    call s:DetectAll()
endfunction

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
