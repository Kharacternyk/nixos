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
set spelllang=en
set termguicolors
set updatetime=300

set iminsert=0

let g:coc_config_home="/etc"
let g:EasyMotion_smartcase=1
let g:gruvbox_italic=1
let g:suda_smart_edit=1
let g:tex_flavor="latex"
let g:vim_markdown_math=1
let g:vim_markdown_folding_disabled=1
let mapleader=" "
let $EDITOR="nvr -p"
let $VISUAL="nvr -p"
let $GIT_EDITOR="nvr --remote-tab-wait"

map <Leader> <Plug>(easymotion-prefix)
map <Leader>; <Plug>(easymotion-repeat)

nmap <Leader>d <Plug>(coc-definition)
nmap <Leader>y <Plug>(coc-type-definition)
nmap <Leader>i <Plug>(coc-implementation)
nmap <Leader>r <Plug>(coc-rename)
nmap <Leader><Leader> <Plug>(coc-fix-current)

noremap <silent><C-_> :nohlsearch<CR>
noremap <silent><C-s> :set spell!<CR>
noremap H ^
noremap L $
noremap S qq
noremap s @q

" To trigger the bullets.vim list completion
map! <C-j> <CR>

noremap! <silent><C-_> <C-o>:nohlsearch<CR>
noremap! <silent><C-s> <C-o>:set spell!<CR>
noremap! <C-Space> <C-^>

nnoremap <silent><nowait><expr> <C-f>
      \ coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b>
      \ coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
vnoremap <silent><nowait><expr> <C-f>
      \ coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b>
      \ coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f>
      \ coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b>
      \ coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <silent><expr> <C-j> coc#pum#visible() ? coc#pum#confirm() : "\<C-j>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

au FileType gitcommit setlocal spell
au FileType gitcommit,gitrebase,gitconfig set bufhidden=delete
au FileType tex map! <buffer> <C-k> <Plug>(vimtex-delim-close)
au FileType html,xml noremap! <buffer> <C-k> </<C-x><C-o><Esc>==A
au BufEnter *.asm setlocal filetype=fasm
au BufWrite * silent! call CocAction('format')
au TermOpen * startinsert

vnoremap y ygv<Esc>

ca H tab help
ca M tab Man
ca W w

colorscheme gruvbox
