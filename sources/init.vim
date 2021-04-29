set background=light
set clipboard+=unnamedplus
set expandtab
set ignorecase
set keymap=ukrainian-jcuken
set laststatus=0
set scrolloff=100
set shortmess+=I
set smartcase
set spell
set spelllang=en,uk,de
set termguicolors

set iminsert=0

au FileType gitcommit,gitrebase,gitconfig set bufhidden=delete
au TermOpen * setlocal nospell
au TermOpen * startinsert

let g:EasyMotion_smartcase=1
let g:gruvbox_italic=1
let g:suda_smart_edit=1
let g:tex_flavor="latex"
let mapleader=" "
let $EDITOR="nvr -p"
let $VISUAL="nvr -p"
let $GIT_EDITOR="nvr --remote-tab-wait"

map <Leader> <Plug>(easymotion-prefix)
map <Leader><Leader> <Plug>(easymotion-repeat)

noremap <silent><C-_> :nohlsearch<CR>
noremap <silent><C-s> :set spell!<CR>
noremap H ^
noremap L $
noremap S qq
noremap s @q

noremap! <silent><C-_> <C-o>:nohlsearch<CR>
noremap! <silent><C-s> <C-o>:set spell!<CR>
noremap! <C-Space> <C-^>

au FileType tex map! <C-k> <Plug>(vimtex-delim-close)
au FileType html,xml noremap! <C-k> </<C-x><C-o><Esc>==A

vnoremap y ygv<Esc>

ca H tab help
ca M tab Man
ca W w

colorscheme gruvbox
