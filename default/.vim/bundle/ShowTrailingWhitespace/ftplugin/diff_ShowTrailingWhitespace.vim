" diff_ShowTrailingWhitespace.vim: Whitespace exceptions for the "diff" filetype.
"
" DEPENDENCIES:
"   - ShowTrailingWhitespace.vim autoload script
"
" Copyright: (C) 2012 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
"   1.00.001	02-Mar-2012	file creation

" A single space at the beginning of a line can represent an empty context line.
call ShowTrailingWhitespace#SetLocalExtraPattern('^\%( \@!\s\)$\|\%>1v')

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
