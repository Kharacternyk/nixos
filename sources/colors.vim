set background=light

" ================
" General settings
" ================

" Inverted stuff
highlight Visual         ctermfg=none ctermbg=none cterm=inverse

" Bold stuff
highlight Search         ctermfg=none ctermbg=none cterm=bold
highlight MatchParen     ctermfg=none ctermbg=none cterm=bold

" Underlined stuff
highlight SpellBad       ctermfg=none ctermbg=none cterm=undercurl guisp=fg
highlight SpellCap       ctermfg=none ctermbg=none cterm=underline guisp=fg
highlight SpellLocal     ctermfg=none ctermbg=none cterm=underline guisp=fg
highlight SpellRare      ctermfg=none ctermbg=none cterm=underline guisp=fg

" Crossed out stuff
highlight Error          ctermfg=8    ctermbg=none cterm=strikethrough

" Italic stuff
highlight Comment        ctermfg=4                 cterm=italic
highlight Todo           ctermfg=4    ctermbg=none cterm=italic

" Custom colors
highlight LineNr         ctermfg=8
highlight ColorColumn    ctermfg=8    ctermbg=none cterm=inverse
highlight Folded         ctermfg=8    ctermbg=none cterm=inverse
highlight FoldColumn     ctermfg=8    ctermbg=none cterm=inverse
highlight SignColumn     ctermfg=8    ctermbg=none cterm=inverse
highlight Pmenu          ctermfg=none ctermbg=none
highlight PmenuSel       ctermfg=none ctermbg=none    cterm=bold
highlight PmenuSbar                   ctermbg=8
highlight PmenuThumb                  ctermbg=4
highlight CursorLineNr   ctermfg=3
highlight Conceal        ctermfg=8    ctermbg=none
highlight CursorColumn   ctermfg=8    ctermbg=none cterm=inverse
highlight Statement      ctermfg=3
highlight DiffAdd        ctermfg=2    ctermbg=none
highlight DiffChange     ctermfg=3    ctermbg=none
highlight DiffDelete     ctermfg=1    ctermbg=none
highlight DiffText       ctermfg=none ctermbg=none cterm=none
highlight ErrorMsg       ctermfg=1    ctermbg=none cterm=inverse
highlight TabLine        ctermfg=none ctermbg=none cterm=inverse

" =================
" Language settings
" =================

" LaTeX
highlight texZone        ctermfg=6    ctermbg=none

" Python
highlight pythonClassVar ctermfg=5

" ===============
" Plugin settings
" ===============

" EasyMotion
highlight EasyMotionTarget        ctermfg=1 cterm=bold
highlight EasyMotionTarget2First  ctermfg=1 cterm=bold
highlight EasyMotionTarget2Second ctermfg=8 cterm=bold
highlight EasyMotionShade         ctermfg=8 cterm=none
