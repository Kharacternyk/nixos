set background=light

" ================
" General settings
" ================

" Inverted stuff
highlight Visual         ctermfg=NONE ctermbg=NONE cterm=inverse

" Bold stuff
highlight Search         ctermfg=NONE ctermbg=NONE cterm=bold
highlight MatchParen     ctermfg=NONE ctermbg=NONE cterm=bold

" Underlined stuff
highlight SpellBad       ctermfg=NONE ctermbg=NONE cterm=undercurl guisp=fg
highlight SpellCap       ctermfg=NONE ctermbg=NONE cterm=underline guisp=fg
highlight SpellLocal     ctermfg=NONE ctermbg=NONE cterm=underline guisp=fg
highlight SpellRare      ctermfg=NONE ctermbg=NONE cterm=underline guisp=fg

" Crossed out stuff
highlight Error          ctermfg=8    ctermbg=NONE cterm=strikethrough

" Italic stuff
highlight Comment        ctermfg=4                 cterm=italic
highlight Todo           ctermfg=4    ctermbg=NONE cterm=italic

" Custom colors
highlight LineNr         ctermfg=8
highlight ColorColumn    ctermfg=7    ctermbg=8
highlight Folded         ctermfg=7    ctermbg=8
highlight FoldColumn     ctermfg=7    ctermbg=8
highlight SignColumn                  ctermbg=8
highlight Pmenu          ctermfg=NONE ctermbg=NONE
highlight PmenuSel       ctermfg=0    ctermbg=4
highlight PmenuSbar                   ctermbg=NONE
highlight PmenuThumb                  ctermbg=4
highlight CursorLineNr   ctermfg=3
highlight Conceal        ctermfg=7    ctermbg=8
highlight CursorColumn   ctermfg=7    ctermbg=8
highlight Statement      ctermfg=3
highlight DiffAdd        ctermfg=2    ctermbg=0
highlight DiffChange     ctermfg=3    ctermbg=0
highlight DiffDelete     ctermfg=1    ctermbg=0
highlight DiffText       ctermfg=7    ctermbg=0    cterm=NONE
highlight ErrorMsg       ctermfg=0    ctermbg=1

" =================
" Language settings
" =================

" LaTeX
highlight texZone        ctermfg=6    ctermbg=NONE

" Python
highlight pythonClassVar ctermfg=5

" ===============
" Plugin settings
" ===============

" EasyMotion
highlight EasyMotionTarget        ctermfg=1 cterm=bold
highlight EasyMotionTarget2First  ctermfg=1 cterm=bold
highlight EasyMotionTarget2Second ctermfg=8 cterm=bold
highlight EasyMotionShade         ctermfg=8 cterm=NONE
