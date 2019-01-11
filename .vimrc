" ~/.vimrc

" Plugins {{{

call plug#begin('~/.vim/plugged')

Plug 'chriskempson/base16-vim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'scrooloose/nerdcommenter'

Plug 'w0rp/ale'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --all' }
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
Plug 'SirVer/ultisnips'
Plug 'ervandew/supertab'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vader.vim',  { 'on': 'Vader', 'for': 'vader' }
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
Plug 'junegunn/limelight.vim', { 'on': 'Limelight' }

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-repeat'

Plug 'jiangmiao/auto-pairs'

Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'

Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoInstallBinaries' }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'rhysd/vim-crystal', { 'for': 'crystal' }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'tikhomirov/vim-glsl', { 'for': 'glsl' }

call plug#end()

" }}}

" Options {{{

let g:colors_name = 'base16-eighties'
let g:base16colorspace = 256
silent! colorscheme base16-eighties

set autoindent
set autoread
set backspace=indent,eol,start
set background=dark
set colorcolumn=120
set expandtab
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set list
set listchars=tab:>-,trail:-,nbsp:?
set modeline
set modelines=5
set nrformats=alpha,bin,hex
set number
set numberwidth=4
set ruler
set shiftround
set shiftwidth=4
set showmatch
set smartcase
set smartindent
set smarttab
set softtabstop=4
" set noswapfile
set tabstop=4
set visualbell
set nowrap

" }}}

" Variables {{{

let g:airline#extensions#ale#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'base16'
let g:ale_fix_on_save = 1
let g:ale_fixers = { '*': ['remove_trailing_lines', 'trim_whitespace'] }
let g:ale_lint_on_text_changed = 0
let g:asmsyntax = 'nasm'
let g:go_fmt_command = 'goimports'
let g:mapleader = ' '
let g:NERDSpaceDelims = 1
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
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']

if !has('nvim')

    let &t_SI = "\<Esc>[6 q"
    let &t_SR = "\<Esc>[4 q"
    let &t_EI = "\<Esc>[2 q"
    let g:AutoPairsShortcutFastWrap = ''

    if has('terminal')
        packadd termdebug
        let g:termdebug_wide = 120
    endif

endif

" }}}

" Key Bindings {{{

nnoremap <C-h> <C-w><C-h>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>

nnoremap <C-p> :FZF<CR>
nnoremap <S-t> :Tags<CR>

nnoremap <leader><Space> :noh<CR>
nnoremap <leader>go :Goyo<CR>
nnoremap <leader>li :set invlist<CR>
nnoremap <leader>nt :NERDTreeToggle<CR>
nnoremap <leader>pa :set invpaste<CR>
nnoremap <leader>so :so %<CR>
nnoremap <leader>tb :TagbarToggle<CR>
nnoremap <leader>us :UltiSnipsEdit<CR>
nnoremap <leader>vi :vsplit ~/.vimrc<CR>

" }}}

" Autocommands {{{

augroup init
    autocmd!
    autocmd! User GoyoEnter Limelight
    autocmd! User GoyoLeave Limelight!
augroup END

" }}}

" Pack {{{

if has('packloadall')
    packloadall
    silent! helptags ALL
endif

" }}}

" vim: foldmethod=marker
