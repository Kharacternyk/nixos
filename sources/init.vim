set clipboard+=unnamedplus
set expandtab
set ignorecase
set keymap=ukrainian-jcuken
set laststatus=0
set scrolloff=100
set shiftwidth=4
set shortmess+=I
set smartcase
set spell
set spelllang=en,uk,de
set tabstop=4

set iminsert=0

let g:EasyMotion_smartcase=1
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-q>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-q>"
let g:python_highlight_all=1
let g:suda_smart_edit=1
let g:tex_flavor="latex"
let mapleader=" "
let $EDITOR="nvr -p"
let $VISUAL="nvr -p"
let $GIT_EDITOR="nvr --remote-tab-wait"

map <Leader> <Plug>(easymotion-prefix)
map <Leader><Leader> <Plug>(easymotion-repeat)

noremap <silent><C-l> :nohlsearch<CR>
noremap <silent><C-s> :set spell!<CR>

noremap! <silent><C-l> <C-o>:nohlsearch<CR>
noremap! <silent><C-s> <C-o>:set spell!<CR>
noremap! <C-Space> <C-^>

nnoremap H ^
nnoremap L $
nnoremap S qq
nnoremap s @q

ca H tab help
ca M tab Man

au FileType gitcommit,gitrebase,gitconfig set bufhidden=delete
au TermOpen * setlocal nospell
au TermOpen * startinsert
