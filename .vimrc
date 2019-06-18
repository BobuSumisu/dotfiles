call plug#begin('~/.vim/plugged')

Plug 'arcticicestudio/nord-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
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
Plug 'ncm2/ncm2-path'
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
" Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'

Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoInstallBinaries' }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'rhysd/vim-crystal', { 'for': 'crystal' }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'tikhomirov/vim-glsl', { 'for': 'glsl' }

call plug#end()

colorscheme nord

" Cooler cursor in vim.
if !has('nvim')
    let &t_SI = "\<Esc>[6 q"
    let &t_SR = "\<Esc>[4 q"
    let &t_EI = "\<Esc>[2 q"
endif

set autoindent                          " Copy indent from current line when starting a new line (vim off, nvim on).
set autoread                            " Automatically read when file changed outside vim (vim off, nvim on).
set background=dark                     " Adjust colors to a dark background (vim guesses, nvim dark).
set backspace=indent,eol,start          " Change how <BS> etc. work in insert mode (vim "", nvim "indent,eol,start").
set colorcolumn=+1                      " Color column at textwidth+1 (vim/nvim 0).
set expandtab                           " Use spaces in indents (vim/nvim off).
set hlsearch                            " Highlight search matches (vim off, nvim on).
set ignorecase                          " Ignore case in search patterns (vim/nvim off).
set incsearch                           " Show matches while typing (vim off, nvim on).
set laststatus=2                        " Alway show a status line (vim 1, nvim 2).
set list                                " List mode, show tabs, trailing spaces and nbsps (vim/nvim off).
set listchars=tab:>-,trail:-,nbsp:?     " Characters in list mode (vim "eol:$", nvim "tab:> ,trail:-,nbsp:+").
set modeline                            " Use modeline (vim off (Debian), nvim on).
set noswapfile                          " Disable swap file (vim/nvim on).
set nrformats=alpha,bin,hex             " Number bases for CTRL-A and CTRL-X (vim "bin,octal,hex", nvim "bin,hex").
set number                              " Show line numbers (vim/nvim off).
set ruler                               " Show line and column number (vim off, nvim on).
set shiftround                          " Round indent to multiple of 'shiftwidth' (vim/nvim off).
set shiftwidth=4                        " Numbers of spaces to use for each step of (auto)indent (vim/nvim 8).
set showmatch                           " Show matching brackets by briefly jumping to it (vim/nvim off).
set smartcase                           " Override 'ignorecase' in searches if the patters contains upper case characters (vim/nvim off).
set smartindent                         " Smart autoindenting (vim/nvim off).
set smarttab                            " Smart tab in front of a line (vim off, nvim on).
set softtabstop=4                       " Number of spaces that <Tab> counts for in editing operations (vim/nvim 0).
set tabstop=4                           " Number of spaces that <Tab> counts for (vim/nvim 8).
set textwidth=119                       " Maximum width of text that is being inserted (vim/nvim 0).
set wildmenu                            " Command-line completion in enhanced mode (vim off, nvim on).

let g:python3_host_prog='/usr/bin/python3'
let $NVIM_PYTHON_LOG_FILE="/tmp/nvim_log"
let $NVIM_PYTHON_LOG_LEVEL="DEBUG"

let g:asmsyntax = 'nasm'                " Use nasm for assembly syntax (TODO: move to autocommand?).

let g:airline#extensions#tabline#enabled = 1

let g:ale_c_clang_options = '-std=gnu11 -Wall -Wextra -Wpedantic'
let g:ale_c_gcc_options = '-std=gnu11 -Wall -Wextra -Wpedantic'
let g:ale_cpp_clang_options = '-std=c++1z -Wall -Wextra -Wpedantic'
let g:ale_c_parse_makefile = 1
let g:ale_fix_on_save = 1
let g:ale_fixers = { '*': ['remove_trailing_lines', 'trim_whitespace'] }
let g:ale_lint_on_text_changed = 0

let g:fzf_command_prefix = 'Fzf'

let g:go_fmt_command = 'goimports'

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

command! W w

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

augroup init
    autocmd!
    autocmd! User GoyoEnter Limelight
    autocmd! User GoyoLeave Limelight!
    autocmd! FileType qf wincmd J
    autocmd! BufNewFile,BufRead *.vs,*.fs set filetype=glsl
    autocmd! BufNewFile,BufRead *.go set nolist
augroup END

augroup NCM2
    autocmd!
    autocmd BufEnter * call ncm2#enable_for_buffer()
    set completeopt=noinsert,menuone,noselect
augroup END

if has('packloadall')
    packloadall
    silent! helptags ALL
endif
