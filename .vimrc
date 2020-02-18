" ~/.vimrc
scriptencoding utf-8

""" Plugins {{{

call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'
Plug 'preservim/nerdtree'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

Plug 'junegunn/fzf.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'skywind3000/gutentags_plus'
Plug 'dense-analysis/ale'
Plug 'maximbaz/lightline-ale'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'fatih/vim-go', { 'for': 'go'  }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'rhysd/vim-crystal', { 'for': 'crystal' }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'mattn/emmet-vim'

Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'

call plug#end()

" }}}

""" Editor configuration {{{

silent! colorscheme gruvbox
set autoindent
set autoread
set background=dark
set backspace=indent,eol,start
set cmdheight=1
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
set signcolumn=yes
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

" }}}

""" Plugin configuration {{{

let g:asmsyntax                     = 'nasm'
let g:fzf_command_prefix            = 'Fzf'

let g:gen_tags#ctags_auto_gen       = 1
let g:gen_tags#gtags_auto_gen       = 1

let g:go_fmt_command                = 'goimports'
let g:go_fmt_fail_silently          = 1
let g:go_highlight_extra_types      = 1
let g:go_highlight_fields           = 1
let g:go_highlight_function_calls   = 1
let g:go_highlight_functions        = 1
let g:go_highlight_operators        = 1
let g:go_highlight_types            = 1
let g:go_metalinter_autosave        = 0
let g:go_metalinter_enabled         = ['vet', 'golint', 'errcheck']

let g:lightline = {
            \ 'colorscheme': 'gruvbox',
            \ 'active': {
            \   'left': [
            \       ['mode', 'paste'],
            \       ['gitbranch', 'readonly', 'filename', 'modified']
            \   ],
            \   'right': [
            \       ['lineinfo'],
            \       ['percent'],
            \       ['fileformat', 'fileencoding', 'filetype'],
            \       ['linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok']
            \   ],
            \ },
            \ 'component_function': {
            \   'gitbranch': 'fugitive#head'
            \ },
            \ 'component_expand': {
            \   'linter_checking': 'lightline#ale#checking',
            \   'linter_warnings': 'lightline#ale#warnings',
            \   'linter_errors': 'lightline#ale#errors',
            \   'linter_ok': 'lightline#ale#ok',
            \ },
            \ 'component_type': {
            \   'linter_checking': 'left',
            \   'linter_warnings': 'warning',
            \   'linter_errors': 'error',
            \   'linter_ok': 'left',
            \ },
            \ }

let g:termdebug_wide                = 120

let g:rust_fold                     = 1
let g:rustfmt_autosave              = 0

let g:ale_fix_on_save = 1
let g:ale_fixers = {
            \ '*': ['remove_trailing_lines', 'trim_whitespace'],
            \ 'rust': ['rustfmt'],
            \}
let g:ale_linters = {
            \ 'rust': ['rls', 'cargo'],
            \}
let g:ale_rust_cargo_use_clippy = 1
let g:ale_rust_cargo_clippy_options = '-- -W clippy::nursery -W clippy::pedantic'
let g:ale_rust_rls_config = { 'rust': { 'clippy_preference': 'on' } }
let g:ale_c_parse_makefile = 1
let g:ale_c_clang_options = '-std=c11 -Wall -Wextra -Wpedantic -Werror'
let g:ale_c_gcc_options = '-std=c11 -Wall -Wextra -Wpedantic -Werror'

inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

let g:coc_snippet_next = '<tab>'

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

""" }}}

""" Key bindings {{{

let g:mapleader = ' '

nnoremap <C-n>              :FzfBuffers<CR>
nnoremap <C-h>              <C-w><C-h>
nnoremap <C-j>              <C-w><C-j>
nnoremap <C-k>              <C-w><C-k>
nnoremap <C-l>              <C-w><C-l>
nnoremap <C-p>              :FzfFiles<CR>
nnoremap <leader><Space>    :noh<CR>
nnoremap <leader>li         :set invlist<CR>
nnoremap <leader>pa         :set invpaste<CR>
nnoremap <leader>rr         :!!<CR>
nnoremap <leader>so         :so %<CR>
nnoremap <leader>tb         :TagbarToggle<CR>
nnoremap <leader>ee         :vsplit ~/.vimrc<CR>
nnoremap <leader>us         :UltiSnipsEdit<CR>
nnoremap <leader>go         :Goyo<CR>
nnoremap <leader>nt         :NERDTreeToggle<CR>
nnoremap <S-t>              :FzfTags<CR>

nnoremap <leader>an         :ALENextWrap<CR>
nnoremap <leader>ap         :ALEPreviousWrap<CR>
nnoremap <leader>ah         :ALEHover<CR>
nnoremap <leader>ag         :ALEGoToDefinition<CR>
nnoremap <leader>ar         :ALERename<CR>

nnoremap <leader>wp         :FzfFiles ~/.vimwiki<CR>

nnoremap ]c :ALENextWrap<CR>
nnoremap [c :ALEPreviousWrap<CR>

nmap ø [
nmap æ ]
omap ø [
omap æ ]
xmap ø [
xmap æ ]

""" }}}

""" Commands {{{

command! W w

""" }}}

""" Autocommands {{{

augroup init
    autocmd!
    autocmd BufNewFile,BufRead *.go set nolist
    autocmd BufNewFile,BufRead *.vs,*.fs set filetype=glsl
    autocmd CompleteDone * pclose
    autocmd FileType qf wincmd J
    autocmd FileType markdown setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType json setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END

""" }}}

""" Packages {{{

if has('packloadall')
    packloadall
    silent! helptags ALL
endif

""" }}}

" vim: set foldmethod=marker:
