hi Normal guibg=#FFFFFF ctermbg=231 guifg=#4E4E4E ctermfg=239

hi Cursor guibg=#af5fd7 ctermbg=134 guifg=#4E4E4E ctermfg=239
hi Comment guifg=#A8A8A8 ctermfg=248 gui=italic

hi Constant guifg=#af5fd7 ctermfg=134
hi! link Character        Constant
hi! link Number           Constant
hi! link Boolean          Constant
hi! link Float            Constant
hi! link String           Constant

hi! link Identifier       Normal
hi! link Function         Identifier

hi Statement guifg=#767676 ctermfg=243
hi! link Conditonal       Statement
hi! link Repeat           Statement
hi! link Label            Statement
hi! link Keyword          Statement
hi! link Exception        Statement

hi Operator guifg=#4E4E4E ctermfg=239 cterm=bold gui=bold

hi PreProc guifg=#767676 ctermfg=243
hi! link Include          PreProc
hi! link Define           PreProc
hi! link Macro            PreProc
hi! link PreCondit        PreProc

hi Type guifg=#4E4E4E ctermfg=239
hi! link StorageClass     Type
hi! link Structure        Type
hi! link Typedef          Type

hi Special guifg=#767676 ctermfg=243 gui=italic
hi! link SpecialChar      Special
hi! link Tag              Special
hi! link Delimiter        Special
hi! link SpecialComment   Special
hi! link Debug            Special

hi Underlined guifg=#4E4E4E ctermfg=239 gui=underline cterm=underline
hi Ignore guifg=#FFFFFF ctermfg=231
hi Error guifg=#FFFFFF ctermfg=231 guibg=#C30771 ctermbg=1 cterm=bold
hi NvimInternalErrorMsg guifg=#FFFFFF ctermfg=231 guibg=#C30771 ctermbg=1 cterm=bold
hi Todo guifg=#af5fd7 ctermfg=134 gui=underline cterm=underline ctermbg=none guibg=none
hi SpecialKey guifg=#606060 ctermfg=241
hi NonText guifg=#767676 ctermfg=243
hi Directory guifg=#008EC4 ctermfg=4
hi ErrorMsg guifg=#fb007a ctermfg=9 guibg=NONE ctermbg=NONE
hi IncSearch guibg=#F3E430 ctermbg=11 guifg=#4E4E4E ctermfg=239 gui=NONE cterm=NONE
hi Search guibg=#A8A8A8 ctermbg=248 guifg=#F1F1F1 ctermfg=15
hi MoreMsg guifg=#767676 ctermfg=243 cterm=bold gui=bold
hi! link ModeMsg MoreMsg
hi LineNr guifg=#A8A8A8 ctermfg=248
hi CursorLineNr guifg=#af5fd7 ctermfg=134 guibg=#EEEEEE ctermbg=255
hi Question guifg=#C30771 ctermfg=1
hi StatusLine guibg=#EEEEEE ctermbg=255 gui=bold cterm=bold
hi StatusLineNC guibg=#EEEEEE ctermbg=255 gui=NONE cterm=NONE
hi VertSplit guibg=#EEEEEE ctermbg=255 guifg=#EEEEEE ctermfg=255
hi Title guifg=#008EC4 ctermfg=4
hi Visual guifg=#4E4E4E ctermfg=239 guibg=#af5fd7 ctermbg=134 cterm=none gui=none
hi VisualNOS guibg=#A8A8A8 ctermbg=248 cterm=none gui=none
hi WarningMsg guifg=#C30771 ctermfg=1 cterm=none gui=none
hi WildMenu guifg=#FFFFFF ctermfg=231 guibg=#4E4E4E ctermbg=239
hi Folded guifg=#767676 ctermfg=243 guibg=none ctermbg=none
hi FoldColumn guibg=#EEEEEE ctermbg=255 guifg=none ctermfg=none gui=none cterm=none
hi DiffAdd     guifg=#10A778 ctermfg=2 guibg=none ctermbg=none
hi diffAdded   guifg=#10A778 ctermfg=2 guibg=none ctermbg=none
hi DiffDelete  guifg=#C30771 ctermfg=1 guibg=none ctermbg=none
hi diffRemoved guifg=#C30771 ctermfg=1 guibg=none ctermbg=none
hi DiffChange  guifg=#A89C14 ctermfg=3 guibg=none ctermbg=none
hi DiffText    guifg=#008EC4 ctermfg=4 guibg=none ctermbg=none

hi SpellBad cterm=underline guifg=#C30771 ctermfg=1
hi SpellCap cterm=underline guifg=#5FD7A7 ctermfg=10
hi SpellRare cterm=underline guifg=#fb007a ctermfg=9
hi SpellLocal cterm=underline guifg=#10A778 ctermfg=2

hi Pmenu guifg=#4E4E4E ctermfg=239 guibg=#A8A8A8 ctermbg=248
hi PmenuSel guifg=#4E4E4E ctermfg=239 guibg=#af5fd7 ctermbg=134
hi PmenuSbar guifg=#4E4E4E ctermfg=239 guibg=#A8A8A8 ctermbg=248
hi PmenuThumb guifg=#4E4E4E ctermfg=239 guibg=#A8A8A8 ctermbg=248
hi TabLine guifg=#4E4E4E ctermfg=239 guibg=#EEEEEE ctermbg=255
hi TabLineSel guifg=#af5fd7 ctermfg=134 guibg=#A8A8A8 ctermbg=248 gui=bold cterm=bold
hi TabLineFill guifg=#4E4E4E ctermfg=239 guibg=#EEEEEE ctermbg=255
hi CursorColumn guibg=#EEEEEE ctermbg=255
hi CursorLine guibg=#EEEEEE ctermbg=255
hi ColorColumn guibg=#A8A8A8 ctermbg=248

hi MatchParen guibg=#A8A8A8 ctermbg=248 guifg=#4E4E4E ctermfg=239
hi qfLineNr guifg=#767676 ctermfg=243

hi htmlH1 guibg=#FFFFFF ctermbg=231 guifg=#4E4E4E ctermfg=239
hi htmlH2 guibg=#FFFFFF ctermbg=231 guifg=#4E4E4E ctermfg=239
hi htmlH3 guibg=#FFFFFF ctermbg=231 guifg=#4E4E4E ctermfg=239
hi htmlH4 guibg=#FFFFFF ctermbg=231 guifg=#4E4E4E ctermfg=239
hi htmlH5 guibg=#FFFFFF ctermbg=231 guifg=#4E4E4E ctermfg=239
hi htmlH6 guibg=#FFFFFF ctermbg=231 guifg=#4E4E4E ctermfg=239

" Signify, git-gutter
hi link SignifySignAdd              LineNr
hi link SignifySignDelete           LineNr
hi link SignifySignChange           LineNr
hi link GitGutterAdd                LineNr
hi link GitGutterDelete             LineNr
hi link GitGutterChange             LineNr
hi link GitGutterChangeDelete       LineNr
hi NeomakeErrorSign   ctermfg=1    ctermbg=none cterm=none
hi NeomakeWarningSign ctermfg=5    ctermbg=none cterm=none

" Signcolumn
hi SignColumn guibg=#EEEEEE ctermbg=255 guifg=none ctermfg=none gui=none cterm=none
hi LspDiagnosticsErrorSign guifg=#C30771 ctermfg=1    guibg=#EEEEEE ctermbg=255
hi LspDiagnosticsWarningSign guifg=#af5fd7 ctermfg=134 guibg=#EEEEEE ctermbg=255
hi LspDiagnosticsInformationSign guifg=#20A5BA ctermfg=6   guibg=#EEEEEE ctermbg=255
hi LspDiagnosticsHintSign guifg=#4E4E4E ctermfg=239  guibg=#EEEEEE ctermbg=255
