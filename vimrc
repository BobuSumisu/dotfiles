call plug#begin('~/.vim/plugged')

Plug 'chriskempson/base16-vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
Plug 'junegunn/limelight.vim', { 'on': 'Limelight' }

Plug 'tpope/vim-fugitive'
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'jiangmiao/auto-pairs'

Plug 'SirVer/ultisnips'
Plug 'ervandew/supertab'
Plug 'w0rp/ale'

Plug 'Valloric/YouCompleteMe', { 'do': './install.py --all' }
Plug 'rdnetto/YCM-Generator', { 'on': 'YcmGenerateConfig' }

Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoInstallBinaries' }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'rhysd/vim-crystal', { 'for': 'crystal' }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'tikhomirov/vim-glsl', { 'for': 'glsl' }

call plug#end()

filetype plugin indent on
syntax enable

if filereadable(expand('~/.vimrc_background'))
    let g:base16colorspace=256
    source ~/.vimrc_background
endif

set colorcolumn=120
set number
set list listchars=tab:>-,trail:-,extends:>,precedes:<,nbsp:?
set laststatus=2
set backspace=indent,eol,start
set tabstop=4 softtabstop=4 shiftwidth=4 shiftround expandtab smartindent
set showmatch incsearch hlsearch ignorecase smartcase gdefault
set modeline
set encoding=utf-8 fileencoding=utf-8 fileformat=unix

let g:airline#extensions#ale#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'base16'
let g:ale_fix_on_save = 1
let g:ale_fixers = { '*': ['remove_trailing_lines', 'trim_whitespace'] }
let g:asmsyntax = 'nasm'
let g:go_fmt_command = 'goimports'
let g:mapleader = ' '
let g:rustfmt_autosave = 1
let g:SuperTabDefaultCompletionType = '<C-n>'
let g:SuperTabDefaultCompletionType = '<c-n>'
let g:UltiSnipsEditSplit = 'vertical'
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsSnippetDirectories = [$HOME.'/.vim/UltiSnips']
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']

nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-h> <C-w><C-h>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-p> :Files<CR>
nnoremap <C-b> :Buffers<CR>
nnoremap <S-t> :Tags<CR>

nnoremap <leader><Space> :nohlsearch<CR>
nnoremap <leader>cb :%w !xclip -selection clipboard<CR>
nnoremap <leader>go :Goyo<CR>
nnoremap <leader>li :set invlist<CR>
nnoremap <leader>nt :NERDTreeToggle<CR>
nnoremap <leader>pa :set invpaste<CR>
nnoremap <leader>so :so %<CR>
nnoremap <leader>tb :TagbarToggle<CR>
nnoremap <leader>us :UltiSnipsEdit<CR>
nnoremap <leader>vi :vsplit $MYVIMRC<CR>

augroup vimrc
    autocmd!
    autocmd User GoyoEnter Limelight
    autocmd User GoyoLeave Limelight!
augroup END

packloadall
silent! helptags ALL
