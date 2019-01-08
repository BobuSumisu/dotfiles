
" Plugins {{{
call plug#begin()

Plug 'tpope/vim-sensible'
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

Plug 'chriskempson/base16-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

Plug 'tpope/vim-fugitive'
Plug 'w0rp/ale'
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
Plug 'zchee/deoplete-clang'
Plug 'SirVer/ultisnips'
Plug 'ervandew/supertab'
Plug 'sakhnik/nvim-gdb', { 'do': './install.sh' }

Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries', 'for': 'go'}
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'rhysd/vim-crystal', { 'for': 'crystal' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }

call plug#end()
" }}}

" General {{{
set conceallevel=0 foldmethod=marker
set encoding=utf-8 fileencoding=utf-8 fileformat=unix
set incsearch ignorecase smartcase hlsearch
set list number title colorcolumn=120 visualbell
set modeline modelines=5
set ruler laststatus=2 showcmd showmode
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab autoindent
set completeopt-=preview
" }}}

if filereadable(expand('~/.vimrc_background'))
    let g:base16colorspace=256
    source ~/.vimrc_background
endif

" Global Variables {{{
let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/local/bin/python3.7'
let g:airline#extensions#ale#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'base16'
let g:ale_fix_on_save = 1
let g:ale_fixers = { '*': ['remove_trailing_lines', 'trim_whitespace'] }
let g:deoplete#enable_at_startup = 1
let g:go_fmt_command = 'goimports'
let g:mapleader = ' '
let g:rustfmt_autosave = 1
let g:SuperTabDefaultCompletionType = '<c-n>'
let g:UltiSnipsEditSplit = 'vertical'
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsSnippetDirectories = [$HOME.'/.config/nvim/UltiSnips']
let g:deoplete#sources#clang#libclang_path = '/usr/lib/x86_64-linux-gnu/libclang-4.0.so.1'
" }}}

" Keys {{{
tmap <Esc> <C-\><C-n>

nnoremap <c-h> <c-w><c-h>
nnoremap <c-j> <c-w><c-j>
nnoremap <c-k> <c-w><c-k>
nnoremap <c-l> <c-w><c-l>
nnoremap <c-p> :Files<CR>
nnoremap <s-b> :Buffers<CR>
nnoremap <s-t> :Tags<CR>

nnoremap <leader><Space> :nohlsearch<CR>

nnoremap <leader>be :%!xxd<CR>
nnoremap <leader>bp :echo eval(line2byte(line("."))+col("."))<CR>
nnoremap <leader>bs :%!xxd -r<CR>
nnoremap <leader>cb :%w !xclip -selection clipboard<CR>
nnoremap <leader>go :Goyo<CR>
nnoremap <leader>li :set invlist<CR>
nnoremap <leader>nt :NERDTreeToggle<CR>
nnoremap <leader>pa :set invpaste<CR>
nnoremap <leader>so :so %<CR>
nnoremap <leader>t2 :setl sw=2 ts=2 sts=2<CR>
nnoremap <leader>t4 :setl sw=4 ts=4 sts=4<CR>
nnoremap <leader>t8 :setl sw=8 ts=8 sts=8<CR>
nnoremap <leader>tb :TagbarToggle<CR>
nnoremap <leader>us :UltiSnipsEdit<CR>
nnoremap <leader>vi :vsplit $MYVIMRC<CR>
" }}}

" Autocommands {{{
augroup init
    autocmd!
    autocmd User GoyoEnter Limelight
    autocmd User GoyoLeave Limelight!
augroup END
" }}}

packloadall
silent! helptags ALL
