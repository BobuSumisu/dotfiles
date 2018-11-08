set encoding=utf-8
scriptencoding utf-8

" Plugins {{{
"
call plug#begin('~/.vim/plugged')

Plug 'chriskempson/base16-vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'leafgarland/typescript-vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
Plug 'pangloss/vim-javascript'
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
Plug 'rhysd/vim-crystal'
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tpope/vim-fugitive'
Plug 'valloric/youcompleteme'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'
Plug 'tikhomirov/vim-glsl'

call plug#end()

""" }}}

" General settings {{{

set autoread
set backspace=2
set colorcolumn=120
set conceallevel=0
set expandtab
set fileencoding=utf-8
set fileformat=unix
set foldmethod=marker
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

" Looks {{{

set background=dark
let g:base16colorspace=256
silent! colorscheme base16-eighties

" }}}

" Plugin Settings and Global Variables {{{

let g:airline_powerline_fonts           = 1
let g:airline_symbols_ascii             = 1
let g:airline_theme                     = 'base16'
let g:airline#extensions#ale#enabled    = 1

let g:ale_c_parse_makefile              = 1
let g:ale_c_clang_options               = '-std=gnu11 -Wall -Wextra -Wpedantic -Werror'
let g:ale_cpp_clang_options             = '-std=c++1z -Wall -Wextra -Wpedantic -Werror'
let g:ale_set_loclist                   = 0
let g:ale_set_quickfix                  = 1
let g:ale_fix_on_save                   = 1
let g:ale_keep_list_window_open         = 0
let g:ale_set_highlights                = 0
let g:ale_lint_on_text_changed          = 'never'
let g:ale_sign_error                    = '>>'
let g:ale_sign_warning                  = '>>'
let g:ale_python_pylint_options         = '--rcfile ~/.pylintrc'
let g:ale_python_pylint_use_global      = 0
let g:ale_completion_enabled            = 0
let g:ale_c_clangformat_options         = "-style='{BasedOnStyle: LLVM, IndentWidth: 4}'"

let g:ale_linters = {
\   'c': ['clang', 'clangtidy', 'cppcheck', 'clang-format', 'flawfinder', 'gcc'],
\   'cpp': ['clang', 'clangtidy', 'cppcheck', 'clang-format', 'flawfinder', 'gcc'],
\   'go': ['gometalinter', 'go build', 'go vet', 'gofmt', 'golint'],
\   'python': [],
\}
let g:ale_fixers = { '*': ['remove_trailing_lines', 'trim_whitespace'] }

let g:asmsyntax                         = 'nasm'

let g:ctrlp_custom_ignore = 'build\|tags\|target\|venv\|node_modules\|\v\.(o|so|bin|elf|lock)$'

let g:mapleader                         = ' '

let g:ycm_always_populate_location_list                 = 1
let g:ycm_autoclose_preview_window_after_completion     = 1
let g:ycm_global_ycm_extra_conf                         = '~/.vim/.ycm_extra_conf.py'
let g:ycm_key_list_previous_completion                  = ['<c-p>', '<up>']
let g:ycm_key_list_select_completion                    = ['<c-n>', '<down>']
let g:ycm_min_num_of_chars_for_completion               = 2
let g:ycm_confirm_extra_conf                            = 0

let g:go_fmt_command                    = 'goimports'

" }}}

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
nnoremap <leader>cn     :!cd build; cmake ..<CR>
nnoremap <leader>cm     :!cd build; make -j$(nproc)<CR>
nnoremap <leader>en     :lnext<CR>
nnoremap <leader>ep     :lprev<CR>
nnoremap <leader>li     :set invlist<CR>
nnoremap <leader>mk     :make<CR>
nnoremap <leader>nt     :NERDTreeToggle<CR>
nnoremap <leader>pa     :set invpaste<CR>
nnoremap <leader>so     :so %<CR>
nnoremap <leader>tb     :TagbarToggle<CR>
nnoremap <leader>vi     :vsplit $MYVIMRC<CR>
nnoremap <leader>us     :UltiSnipsEdit<CR>

cmap w!! w !sudo tee > /dev/null %

" }}}

" Autocommands {{{

augroup vimrc
    autocmd!
    autocmd BufEnter * :call QuitIfOnlyNERDTree()
    autocmd FileType qf wincmd J
    autocmd BufReadPost qf nnoremap <buffer> <CR> <CR>
    autocmd BufRead,BufNewFile *.h set filetype=c
    autocmd FileType crystal setlocal sw=2 sts=2 ts=2
    autocmd BufRead,BufNewFile *.vs,*.fs set ft=glsl
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
" }}}

packloadall
silent! helptags ALL
