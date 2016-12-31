" Vim color theme : almost-monochrome.

set background=dark
hi clear
if exists("syntax_on")
	syntax reset
endif
set t_Co=256
let colors_name = "almost-monochrome"

hi Comment              ctermfg=4    ctermbg=none cterm=none
hi Constant             ctermfg=none ctermbg=none cterm=none
hi CursorLine           ctermfg=none ctermbg=none cterm=none
hi CursorLineNr         ctermfg=none ctermbg=none cterm=bold
hi CursorColumn         ctermfg=none ctermbg=none cterm=none
hi ColorColumn          ctermfg=none ctermbg=none cterm=inverse
hi DiffAdd              ctermfg=2    ctermbg=none cterm=none
hi DiffChange           ctermfg=3    ctermbg=none cterm=none
hi DiffDelete           ctermfg=1    ctermbg=none cterm=none
hi DiffText             ctermfg=none ctermbg=none cterm=none
hi Directory            ctermfg=none ctermbg=none cterm=none
hi Foldcolumn           ctermfg=none ctermbg=none cterm=none
hi Folded               ctermbg=none ctermfg=none cterm=none
hi Function             ctermfg=none ctermbg=none cterm=none
hi Identifier           ctermfg=none ctermbg=none cterm=none
hi LineNr               ctermfg=none ctermbg=none cterm=none
hi manReference         ctermfg=4    ctermbg=none cterm=none
hi manSectionHeading    ctermfg=4    ctermbg=none cterm=bold
hi manTitle             ctermfg=none ctermbg=none cterm=none
hi manSubHeading        ctermfg=none ctermbg=none cterm=none
hi manOptionDesc        ctermfg=5    ctermbg=none cterm=none
hi manCFuncDefinition   ctermfg=none ctermbg=none cterm=none
hi manFooter            ctermfg=none ctermbg=none cterm=none
hi MatchParen           ctermfg=0    ctermbg=7    cterm=none
hi MoreMsg              ctermfg=none ctermbg=none cterm=none
hi Normal               ctermfg=none ctermbg=none cterm=none
hi NonText              ctermfg=none ctermbg=none cterm=none
hi Number               ctermfg=none ctermbg=none cterm=none
hi Pmenu                ctermfg=7    ctermbg=0    cterm=none
hi PmenuSel             ctermfg=0    ctermbg=7    cterm=none
hi PreProc              ctermfg=none ctermbg=none cterm=none
hi Question             ctermfg=none ctermbg=none cterm=none
hi Search               ctermfg=none ctermbg=none cterm=underline
hi SignColumn           ctermfg=7    ctermbg=0    cterm=none
hi SpellBad             ctermfg=1    ctermbg=none cterm=none
hi SpellCap             ctermfg=3    ctermbg=none cterm=none
hi SpellRare            ctermfg=none ctermbg=none cterm=none
hi SpellLocal           ctermfg=none ctermbg=none cterm=none
hi Special              ctermfg=none ctermbg=none cterm=none
hi SpecialKey           ctermfg=none ctermbg=none cterm=none
hi Statement            ctermfg=none ctermbg=none cterm=none
hi StatusLine           ctermfg=0    ctermbg=7    cterm=none
hi StatusLineNC         ctermfg=7    ctermbg=0    cterm=none
hi StorageClass         ctermfg=none ctermbg=none cterm=none
hi String               ctermfg=5    ctermbg=none cterm=none
hi SyntasticErrorSign   ctermfg=1    ctermbg=none cterm=none
hi SyntasticWarningSign ctermfg=5    ctermbg=none cterm=none
hi TabLine              ctermfg=7    ctermbg=0    cterm=none
hi TabLineFill          ctermfg=7    ctermbg=0    cterm=none
hi TabLineSel           ctermfg=0    ctermbg=7    cterm=none
hi Title                ctermfg=none ctermbg=none cterm=none
hi Todo                 ctermfg=none ctermbg=none cterm=none
hi Type                 ctermfg=none ctermbg=none cterm=none
hi Underlined           ctermfg=none ctermbg=none cterm=underline
hi VertSplit            ctermfg=0    ctermbg=0    cterm=none
hi Visual               ctermfg=none ctermbg=none cterm=inverse
hi WarningMsg           ctermfg=0    ctermbg=7    cterm=inverse
hi WildMenu             ctermfg=7    ctermbg=0    cterm=bold
