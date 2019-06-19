" ~/.vimrc - hybrid vim/nvim config

" Plugins {{{

call plug#begin('~/.vim/plugged')

Plug 'arcticicestudio/nord-vim'
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'Yggdroot/indentLine'

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'scrooloose/nerdcommenter'

Plug 'w0rp/ale'
Plug 'SirVer/ultisnips'

if !has('nvim')
    Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-gtags'
Plug 'ncm2/ncm2-jedi'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-pyclang'
Plug 'ncm2/ncm2-racer'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vader.vim',  { 'on': 'Vader', 'for': 'vader' }
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
Plug 'junegunn/limelight.vim', { 'on': 'Limelight' }

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-repeat'

Plug 'jsfaint/gen_tags.vim'
Plug 'majutsushi/tagbar'

Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoInstallBinaries' }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'rhysd/vim-crystal', { 'for': 'crystal' }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'tikhomirov/vim-glsl', { 'for': 'glsl' }

call plug#end()

" }}}

" Editor Configuration {{{

silent! colorscheme nord

if !has('nvim')

    " Set cursor style using terminal options.
    let &t_SI = "\<Esc>[6 q"                " Start insert mode: steady line.
    let &t_SR = "\<Esc>[4 q"                " Start replace mode: steady underline.
    let &t_EI = "\<Esc>[2 q"                " End insert mode: steady block.

    set autoindent                          " Copy indent from current line when starting a new line.
    set autoread                            " Automatically read when file changed outside vim.
    set background=dark                     " Adjust colors to a dark background.
    set backspace=indent,eol,start          " Change how <BS> etc. work in insert mode.
    set hlsearch                            " Highlight search matches.
    set incsearch                           " Show matches while typing.
    set listchars=tab:>-,trail:-,nbsp:?     " Characters in list mode.
    set modeline                            " Use modeline (default off in Debian?).
    set ruler                               " Show line and column number.
    set smarttab                            " Smart tab in front of a line.
    set wildmenu                            " Command-line completion in enhanced mode.
endif

set colorcolumn=+1                          " Color column at textwidth+1.
set completeopt=noinsert,menuone,noselect   " Options for ins-completion.
set expandtab                               " Use spaces in indents.
set ignorecase                              " Ignore case in search patterns.
set laststatus=2                            " Alway show a status line.
set list                                    " Turn on list mode: show tabs, trailing spaces and nbsps.
set noswapfile                              " Disable swap file.
set nrformats=alpha,bin,hex                 " Number bases for CTRL-A and CTRL-X.
set number                                  " Show line numbers.
set shiftround                              " Round indent to multiple of 'shiftwidth'.
set shiftwidth=4                            " Numbers of spaces to use for each step of (auto)indent.
set shortmess+=c                            " Don't show ins-completion messages.
set showmatch                               " Show matching brackets by briefly jumping to it.
set showtabline=2                           " Always show tab line.
set smartcase                               " Override 'ignorecase' in searches if it contains upper case characters.
set smartindent                             " Smart autoindenting.
set softtabstop=4                           " Number of spaces that <Tab> counts for in editing operations.
set tabstop=4                               " Number of spaces that <Tab> counts for.
set textwidth=119                           " Maximum width of text that is being inserted.
set ttimeoutlen=0                           " Don't wait for key code sequences to complete.

if has('nvim')
    " Setting these can speed up things and avoid some problems.
    let g:python_host_prog='/usr/bin/python'
    let g:python3_host_prog='/usr/bin/python3'

    " Enable some debugging.
    let $NVIM_PYTHON_LOG_FILE='/tmp/nvim_log'
    let $NVIM_PYTHON_LOG_LEVEL='DEBUG'
endif

" }}}

" Plugin Configuration {{{

let g:ale_c_clang_options = '-std=gnu11 -Wall -Wextra -Wpedantic'
let g:ale_c_gcc_options = '-std=gnu11 -Wall -Wextra -Wpedantic'
let g:ale_cpp_clang_options = '-std=c++1z -Wall -Wextra -Wpedantic'
let g:ale_c_parse_makefile = 1
let g:ale_fix_on_save = 1
let g:ale_fixers = { '*': ['remove_trailing_lines', 'trim_whitespace'] }
let g:ale_lint_on_text_changed = 0

let g:asmsyntax = 'nasm'

let g:fzf_command_prefix = 'Fzf'

let g:go_fmt_command = 'goimports'

let g:lightline = {
            \ 'colorscheme': 'nord',
            \ 'tabline': { 'left': [[ 'buffers' ]], 'right': [[ 'progname' ]] },
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
            \ },
            \ 'component': { 'progname': v:progname },
            \ 'component_function': { 'gitbranch': 'fugitive#head' },
            \ 'component_expand': { 'buffers': 'lightline#bufferline#buffers' },
            \ 'component_type': { 'buffers': 'tabsel' },
            \ }
let g:lightline#bufferline#shorten_path = 1

let g:ncm2_pyclang#library_path = '/usr/lib/llvm-7/lib/libclang.so.1'

let g:NERDSpaceDelims = 1

let g:rustfmt_autosave = 1

let g:UltiSnipsEditSplit = 'vertical'
let g:UltiSnipsExpandTrigger = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsSnippetDirectories = [$HOME.'/.vim/UltiSnips']

if has('terminal')
    let g:termdebug_wide = 120
endif

" }}}

" Key Bindings {{{

let g:mapleader = ' '

nnoremap <C-h> <C-w><C-h>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>

nnoremap <C-p> :FzfFiles<CR>
nnoremap <S-t> :FzfTags<CR>

nnoremap <leader><Space> :noh<CR>

nnoremap <leader>go :Goyo<CR>
nnoremap <leader>li :set invlist<CR>
nnoremap <leader>nt :NERDTreeToggle<CR>
nnoremap <leader>pa :set invpaste<CR>
nnoremap <leader>so :so %<CR>
nnoremap <leader>tb :TagbarToggle<CR>
nnoremap <leader>us :UltiSnipsEdit<CR>
nnoremap <leader>vi :vsplit ~/.vimrc<CR>

inoremap <C-c> <ESC>

" }}}

" Commands {{{

command! W w

" }}}

" Autocommands {{{

augroup init
    autocmd!
    autocmd User GoyoEnter Limelight
    autocmd User GoyoLeave Limelight!
    autocmd FileType qf wincmd J
    autocmd BufNewFile,BufRead *.vs,*.fs set filetype=glsl
    autocmd BufNewFile,BufRead *.go set nolist
    autocmd BufEnter * call ncm2#enable_for_buffer()
    autocmd FileType c,cpp nnoremap <buffer> gd :<c-u>call ncm2_pyclang#goto_declaration()<cr>
augroup END

" }}}

if has('packloadall')
    packloadall
    silent! helptags ALL
endif

" vim:fdm=marker
