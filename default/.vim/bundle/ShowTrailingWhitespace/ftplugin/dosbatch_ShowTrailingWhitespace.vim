" dosbatch_ShowTrailingWhitespace.vim: Whitespace exceptions for the "dosbatch" filetype.
"
" DEPENDENCIES:
"   - ShowTrailingWhitespace.vim autoload script
"
" Copyright: (C) 2013 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
"   1.01.002	04-Dec-2013	Improve pattern.
"   1.01.001	03-Dec-2013	file creation

" A user prompt (set /P query=Your choice? ) may end with a trailing space.
call ShowTrailingWhitespace#SetLocalExtraPattern('\c\%(\<set\s/p\s.*\)\@<!')

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
