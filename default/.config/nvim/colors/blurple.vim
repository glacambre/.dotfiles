" Vim color theme : Blurple.

set background=dark
hi clear
if exists("syntax_on")
	syntax reset
endif
set t_Co=256
let colors_name = "blurple"

hi Comment      ctermfg=145		ctermbg=none	cterm=none
hi Constant     ctermfg=135  	ctermbg=none 	cterm=none
hi CursorLine   ctermfg=none 	ctermbg=none 	cterm=none
hi CursorLineNr ctermfg=135  	ctermbg=none 	cterm=bold
hi CursorColumn ctermfg=none 	ctermbg=235  	cterm=none
hi ColorColumn  ctermfg=none 	ctermbg=none 	cterm=inverse
hi Directory    ctermfg=188  	ctermbg=none 	cterm=none
hi Foldcolumn   ctermfg=none 	ctermbg=none 	cterm=none
hi Folded       ctermbg=59   	ctermfg=188  	cterm=none
hi Function     ctermfg=111  	ctermbg=none 	cterm=none
hi Identifier   ctermfg=75   	ctermbg=none 	cterm=none
hi LineNr       ctermfg=102  	ctermbg=none 	cterm=none
hi MatchParen   ctermfg=188  	ctermbg=111  	cterm=none
hi Normal       ctermfg=250  	ctermbg=236  	cterm=none
hi NonText      ctermfg=110  	ctermbg=none 	cterm=none
hi Number       ctermfg=135  	ctermbg=none 	cterm=none
hi Pmenu        ctermfg=none 	ctermbg=59   	cterm=none
hi PmenuSel     ctermfg=188  	ctermbg=111  	cterm=none
hi PreProc      ctermfg=59   	ctermbg=none 	cterm=none
hi Search       ctermfg=none 	ctermbg=none 	cterm=underline
hi SpellBad     ctermfg=1    	ctermbg=none 	cterm=none
hi Special      ctermfg=188  	ctermbg=none 	cterm=none
hi SpecialKey   ctermfg=113  	ctermbg=none 	cterm=none
hi Statement    ctermfg=75   	ctermbg=none 	cterm=none
hi StatusLine   ctermfg=236  	ctermbg=135  	cterm=none
hi StatusLineNC ctermfg=none 	ctermbg=237  	cterm=none
hi StorageClass ctermfg=75   	ctermbg=none 	cterm=none
hi String       ctermfg=135  	ctermbg=none 	cterm=none
hi TabLine      ctermfg=none 	ctermbg=237  	cterm=none
hi TabLineFill  ctermfg=none 	ctermbg=237  	cterm=none
hi TabLineSel   ctermfg=236  	ctermbg=135  	cterm=none
hi Title        ctermfg=188  	ctermbg=none 	cterm=none
hi Todo         ctermfg=59   	ctermbg=111  	cterm=none
hi Type         ctermfg=75   	ctermbg=none 	cterm=none
hi Underlined   ctermfg=188  	ctermbg=none 	cterm=none
hi VertSplit    ctermfg=237  	ctermbg=237  	cterm=none
hi Visual       ctermfg=188  	ctermbg=135  	cterm=none
hi WildMenu     ctermfg=135 	ctermbg=none  	cterm=none
