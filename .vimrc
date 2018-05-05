set encoding=utf-8
scriptencoding utf-8

" Plugins {{{
call plug#begin('~/.vim/plugged')

Plug 'chriskempson/base16-vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'valloric/youcompleteme'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'

call plug#end()
""" }}}

" General settings {{{
set foldmethod=marker
set autoread
set background=dark
set backspace=2
set colorcolumn=120
set conceallevel=0
set expandtab
set fileencoding=utf-8
set fileformat=unix
set laststatus=2
set list
set listchars=tab:▶–,trail:·,extends:>,precedes:<,nbsp:!
set modeline
set modelines=5
set nobackup
set nofsync
set noswapfile
set nowritebackup
set number
set shiftround
set shiftwidth=4
set showmatch
set smartindent
set softtabstop=4
set swapsync=
set tabstop=4
""" }}}

" Global Variables {{{
let g:airline_powerline_fonts=1
let g:airline_symbols_ascii=1
let g:airline_theme='base16'
let g:ale_python_pylint_executable = 'pylint3'
let g:asmsyntax = 'nasm'
let g:ctrlp_custom_ignore='\v\.(o|so|bin|elf)$'
let g:mapleader=' '
let g:ycm_always_populate_location_list=1
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_global_ycm_extra_conf='~/.vim/.ycm_extra_conf.py'
let g:ycm_key_list_previous_completion=['<c-p>', '<up>']
let g:ycm_key_list_select_completion=['<c-n>', '<down>']
let g:ycm_min_num_of_chars_for_completion=1
let g:ycm_rust_src_path='~/.multirust/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src'
" }}}

if filereadable(expand('~/.vimrc_background'))
    let g:base16colorspace=256
    source ~/.vimrc_background
endif

" Keys {{{
nnoremap <c-j>          <c-w><c-j>
nnoremap <c-k>          <c-w><c-k>
nnoremap <c-h>          <c-w><c-h>
nnoremap <c-l>          <c-w><c-l>
nnoremap <s-t>          :CtrlPTag<CR>
nnoremap <leader>be     :%!xxd<CR>
nnoremap <leader>bp     :echo eval(line2byte(line("."))+col("."))<CR>
nnoremap <leader>bs     :%!xxd -r<CR>
nnoremap <leader>cd     :YcmCompleter GetDoc<CR>
nnoremap <leader>cf     :YcmCompleter FixIt<CR>
nnoremap <leader>cg     :YcmCompleter GoTo<CR>
nnoremap <leader>ci     :YcmCompleter GoToInclude<CR>
nnoremap <leader>cr     :YcmCompleter RestartServer<CR>
nnoremap <leader>ct     :YcmCompleter GetType<CR>
nnoremap <leader>cx     :YcmCompleter GoToReferences<CR>
nnoremap <leader>en     :lnext<CR>
nnoremap <leader>ep     :lprev<CR>
nnoremap <leader>li     :set invlist<CR>
nnoremap <leader>mk     :make<CR>
nnoremap <leader>nt     :NERDTreeToggle<CR>
nnoremap <leader>pa     :set invpaste<CR>
nnoremap <leader>so     :so %<CR>
nnoremap <leader>tb     :TagbarToggle<CR>
nnoremap <leader>vi     :vsplit $MYVIMRC<CR>
" }}}

" Autocommands {{{
augroup vimrc
    autocmd!
    autocmd BufEnter * :call QuitIfOnlyNERDTree()
    autocmd BufWrite * :call RemoveTrailingWhiteSpace()
    autocmd FileType qf wincmd J
    autocmd BufReadPost qf nnoremap <buffer> <CR> <CR>
augroup END
" }}}

" Functions {{{
function! OpenNERDTree()
    NERDTree
    if argc() != 0
        exe "normal \<C-W>\<C-L>"
    endif
endfunction

function! QuitIfOnlyNERDTree()
    if (winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree())
        quit
    endif
endfunction

function! RemoveTrailingWhiteSpace()
    execute 'normal mz'
        %s/\s\+$//ge
    execute 'normal `z'
endfunction
" }}}

packloadall
silent! helptags ALL
