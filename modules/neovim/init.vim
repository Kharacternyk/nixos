set background=light
set clipboard+=unnamedplus
set expandtab
set ignorecase
set keymap=ukrainian-jcuken
set laststatus=0
set scrolloff=100
set shiftwidth=4
set shortmess+=I
set signcolumn=no
set smartcase
set spell
set spelllang=en,uk,de
set termguicolors
set updatetime=300

set iminsert=0

let g:gruvbox_italic=1
let g:suda_smart_edit=1
let g:suda#noninteractive = 1
let g:vim_markdown_math=1
let g:vim_markdown_folding_disabled=1
let mapleader=" "

nmap <silent><Leader>u :UndotreeToggle<CR>

noremap <silent><C-/> :nohlsearch<CR>
noremap <silent><C-s> :set spell!<CR>
noremap <silent><C-y> :set eventignore=BufWrite<CR>
noremap <silent><C-t> :set eventignore=<CR>
noremap <C-Space> a<C-^><Esc>
noremap H ^
noremap L $
noremap S qq
noremap s @q

noremap! <silent><C-/> <C-o>:nohlsearch<CR>
noremap! <silent><C-s> <C-o>:set spell!<CR>
noremap! <C-Space> <C-^>

au BufEnter *.asm setlocal filetype=fasm
au BufEnter *.arb setlocal filetype=json
au BufEnter *.h setlocal filetype=c

vnoremap y ygv<Esc>

ca W w

colorscheme gruvbox
