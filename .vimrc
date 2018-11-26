set encoding=utf-8
scriptencoding utf-8

" Plugins {{{
call plug#begin('~/.vim/plugged')

" Looks and navigation
Plug 'chriskempson/base16-vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'benmills/vimux'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

" Coding utilities
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
Plug 'tpope/vim-fugitive'
Plug 'valloric/youcompleteme'
Plug 'w0rp/ale'

" Languages
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'leafgarland/typescript-vim'
Plug 'pangloss/vim-javascript'
Plug 'rhysd/vim-crystal'
Plug 'rust-lang/rust.vim'
Plug 'tikhomirov/vim-glsl'

call plug#end()
""" }}}

" General Settings {{{

" Looks
let g:base16colorspace=256
set background=dark
set colorcolumn=120
set conceallevel=0
set foldmethod=marker
set laststatus=2
set list
set listchars=tab:>-,trail:-,extends:>,precedes:<,nbsp:?
set number
silent! colorscheme base16-eighties
set visualbell
hi clear SpellBad
hi SpellBad term=underline cterm=underline gui=underline


" Editing
set backspace=indent,eol,start
set expandtab
set shiftround
set shiftwidth=4
set showmatch
set smartindent
set softtabstop=4
set tabstop=4
set incsearch
set hlsearch
set ignorecase
set smartcase
set gdefault

" File options
set fileencoding=utf-8
set fileformat=unix
set modeline
set modelines=5
set nobackup
set nofsync
set noswapfile
set nowritebackup
set swapsync=
set autoread

" Misc.
let g:asmsyntax = 'nasm'

""" }}}

" Plugin Settings {{{

" Airline
let g:airline_powerline_fonts           = 1
let g:airline_symbols_ascii             = 1
let g:airline_theme                     = 'base16'
let g:airline#extensions#ale#enabled    = 1

" Ale
let g:ale_c_clang_options               = '-std=gnu11 -Wall -Wextra -Wpedantic -Werror'
let g:ale_c_parse_makefile              = 1
let g:ale_completion_enabled            = 0
let g:ale_cpp_clang_options             = '-std=c++1z -Wall -Wextra -Wpedantic -Werror'
let g:ale_fix_on_save                   = 1
let g:ale_keep_list_window_open         = 0
let g:ale_lint_on_text_changed          = 'never'
let g:ale_python_pylint_options         = '--rcfile ~/.pylintrc'
let g:ale_python_pylint_use_global      = 1
let g:ale_set_highlights                = 0
let g:ale_set_loclist                   = 0
let g:ale_set_quickfix                  = 1
let g:ale_sign_error                    = '>>'
let g:ale_sign_warning                  = '>>'
let g:ale_linters = {
\   'c':        ['clang', 'gcc'],
\   'cpp':      ['clang'],
\   'go':       ['gometalinter', 'go build', 'go vet', 'gofmt', 'golint'],
\   'python':   ['pylint3', 'flake8'],
\}
let g:ale_fixers = {
\   '*':        ['remove_trailing_lines', 'trim_whitespace']
\}

" CtrlP
let g:ctrlp_custom_ignore = 'build\|tags\|target\|venv\|node_modules\|\v\.(o|so|bin|elf|lock)$'

" YouCompleteMe
let g:ycm_always_populate_location_list                 = 1
let g:ycm_autoclose_preview_window_after_completion     = 1
let g:ycm_global_ycm_extra_conf                         = '~/.vim/.ycm_extra_conf.py'
let g:ycm_key_list_previous_completion                  = ['<c-p>', '<up>']
let g:ycm_key_list_select_completion                    = ['<c-n>', '<down>']
let g:ycm_min_num_of_chars_for_completion               = 2
let g:ycm_confirm_extra_conf                            = 0

" Go
let g:go_fmt_command = 'goimports'

" }}}

" Keys {{{

let g:mapleader = ' '

nnoremap <C-j>          <C-w><C-j>
nnoremap <C-k>          <C-w><C-k>
nnoremap <C-h>          <C-w><C-h>
nnoremap <C-l>          <C-w><C-l>
nnoremap <S-t>          :CtrlPTag<CR>

nnoremap <C-c>          :cc!<CR>
nnoremap <C-n>          :cnext!<CR>
nnoremap <C-p>          :cprev!<CR>

nnoremap / /\v
vnoremap / /\v

nnoremap <leader><Space> :nohlsearch<CR>

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

nnoremap <leader>cc     :cc!<CR>
nnoremap <leader>cn     :cnext!<CR>
nnoremap <leader>cp     :cprev!<cr>

nnoremap <leader>go     :Goyo<CR>

nnoremap <leader>li     :set invlist<CR>
nnoremap <leader>ll     :ll!<CR>
nnoremap <leader>ln     :lnext!<CR>
nnoremap <leader>lp     :lprev!<CR>

nnoremap <leader>mk     :make<CR>
nnoremap <leader>mt     :make test<CR>
nnoremap <leader>mx     :!chmod +x %<CR>

nnoremap <leader>nt     :NERDTreeToggle<CR>

nnoremap <leader>pa     :set invpaste<CR>

nnoremap <leader>so     :so %<CR>

nnoremap <leader>tb     :TagbarToggle<CR>

nnoremap <leader>ve     :vsplit $MYVIMRC<CR>
nnoremap <leader>vp     :VimuxPromptCommand<CR>
nnoremap <leader>vl     :VimuxRunLastCommand<CR>
nnoremap <leader>vi     :VimuxInspectRunner<CR>
nnoremap <leader>vz     :VimuxZoomRunner<CR>

nnoremap <leader>t2     :setl sw=2 ts=2 sts=2<CR>
nnoremap <leader>t4     :setl sw=4 ts=4 sts=4<CR>
nnoremap <leader>t8     :setl sw=8 ts=8 sts=8<CR>

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
    autocmd User GoyoEnter Limelight
    autocmd User GoyoLeave Limelight!
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
