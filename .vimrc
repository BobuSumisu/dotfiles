" ~/.vimrc
scriptencoding utf-8

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Plug 'morhetz/gruvbox'
Plug 'sainnhe/gruvbox-material'
Plug 'itchyny/lightline.vim'

Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

Plug 'ludovicchabant/vim-gutentags'
Plug 'honza/vim-snippets'

Plug 'dense-analysis/ale'
Plug 'sheerun/vim-polyglot'
Plug 'fatih/vim-go'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

silent! colorscheme gruvbox-material
set autoindent
set autoread
set background=dark
set backspace=indent,eol,start
set cmdheight=1
set conceallevel=0
set colorcolumn=+1
set completeopt=noinsert,menuone,noselect
set expandtab
set hidden
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set list
set listchars=tab:>-,trail:-,nbsp:?
set modeline
set nobackup
set noswapfile
set nowritebackup
set nowritebackup
set nrformats=alpha,bin,hex
set number
set ruler
set shiftround
set shiftwidth=4
set shortmess+=c
set showmatch
set showtabline=0
if has('patch-8.1.1564')
    set signcolumn=number
else
    set signcolumn=yes
endif
set smartcase
set smartindent
set smarttab
set softtabstop=4
set shortmess+=c
set tabstop=4
set textwidth=119
set timeout
set timeoutlen=500
set ttimeout
set ttimeoutlen=100
set updatetime=300
set wildmenu

let g:mapleader = ' '

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\}
let g:ale_fix_on_save = 1

let g:gutentags_ctags_exclude = ['.ccls-cache']

let g:go_code_completion_enabled = 0
let g:go_fmt_command = 'goimports'

let g:coc_snippet_next = '<tab>'

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

nnoremap <C-h>              <C-w><C-h>
nnoremap <C-j>              <C-w><C-j>
nnoremap <C-k>              <C-w><C-k>
nnoremap <C-l>              <C-w><C-l>

nnoremap <C-p>              :Files<CR>
nnoremap <S-t>              :Tags<CR>

nnoremap <leader><Space>    :noh<CR>
nnoremap <leader>ee         :vsplit ~/.vimrc<CR>
nnoremap <leader>ni         :vsplit ~/notes/index.md<CR>
nnoremap <leader>so         :so %<CR>
nnoremap <leader>pa         :set invpaste<CR>
nnoremap <leader>li         :set invlist<CR>
nnoremap <leader>cg         :sign unplace *<CR>

nmap <silent> [g            <Plug>(coc-diagnostic-prev)
nmap <silent> ]g            <Plug>(coc-diagnostic-next)
nmap <silent> gd            <Plug>(coc-definition)
nmap <silent> gy            <Plug>(coc-type-definition)
nmap <silent> gi            <Plug>(coc-implementation)
nmap <silent> gr            <Plug>(coc-references)
nmap <leader>rn             <Plug>(coc-rename)
nmap <leader>qf             <Plug>(coc-fix-current)
nmap <leader>ca             <Plug>(coc-codeaction)
nnoremap <silent> K :call CocAction('doHover')<CR>

nmap ø [
nmap æ ]
omap ø [
omap æ ]
xmap ø [
xmap æ ]

augroup init
    autocmd!
    autocmd FileType css,html,yaml,javascript,markdown setlocal sw=2 ts=2 sts=2
    autocmd FileType markdown setlocal textwidth=79
    autocmd FileType go setlocal nolist
    autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
    autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear
augroup END

if has('packloadall')
    packloadall
    silent! helptags ALL
endif
