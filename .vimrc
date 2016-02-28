if has('vim_starting')
  if &compatible
    set nocompatible
  endif

  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'vim-airline/vim-airline'
NeoBundle 'vim-airline/vim-airline-themes'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'ervandew/supertab'
NeoBundle 'SirVer/ultisnips'
NeoBundle 'Valloric/YouCompleteMe'
NeoBundle 'fatih/vim-go'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'godlygeek/tabular'
NeoBundle 'ctrlpvim/ctrlp.vim'

NeoBundle '~/projects/vim/i3'

call neobundle#end()
NeoBundleCheck

if has('autocmd')
  filetype plugin indent on
endif

if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

""" Backup
set nobackup
set noswapfile

""" Modeline
set modeline
set modelines=5

""" Encoding
set fileformat=unix
set fileencoding=utf-8
set encoding=utf-8

""" Indentation
set smartindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

""" Looks
set number
set background=dark
set t_Co=256
let g:solarized_termcolors=16
silent! colorscheme solarized
set colorcolumn=120
set laststatus=2

""" Stop concealing, please
set conceallevel=0
autocmd FileType * setlocal conceallevel=0
autocmd VimEnter,BufEnter,BufNewFile,BufRead * set conceallevel=0

""" Help
autocmd FileType help wincmd L

""" Make
set makeprg=make\ -j$(nproc)

""" NERDTree
" autocmd vimenter * NERDTree
" autocmd VimEnter * wincmd p
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

""" VimAirline
"let g:airline_powerline_fonts = 0

""" SuperTab
let g:SuperTabDefaultCompletionType='<C-n>'
let g:SuperTabCrMapping=0

""" UltiSnips
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'
let g:UltiSnipsEditSplit="vertical"

""" YouCompleteMe
" let g:ycm_path_to_python_interpreter='/usr/bin/python2'
let g:ycm_key_list_select_completion=['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion=['<C-p>', '<Up>']
let g:ycm_global_ycm_extra_conf='~/.vim/.ycm_extra_conf.py'
autocmd CompleteDone * pclose

""" Scheme
set lispwords+=match,receive,module
syn keyword schemeFunc match receive module

""" Go
let g:go_fmt_command="goimports"

""" Markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd BufNewFile,BufRead,BufEnter *.md :syn match markdownIgnore "stem:\[.*\]"
autocmd BufNewFile,BufRead,BufEnter *.md :syn match markdownIgnore "_"

""" Json
autocmd BufNewFile,BufRead,BufEnter *.json setl cole=0
let g:vim_json_syntax_conceal = 0

""" Tex
let g:tex_conceal = ""

""" Keys
let mapleader=" "

nnoremap <Leader>jd :YcmCompleter GoTo<CR>
nnoremap <Leader>l :set list<CR>
nnoremap <Leader>L :set nolist<CR>
nnoremap <Leader>m :make!<CR>
nnoremap <Leader>n :NERDTree<CR>
nnoremap <Leader>N :NERDTreeClose<CR>
nnoremap <Leader>P :set nopaste<CR>
nnoremap <Leader>p :set paste<CR>
nnoremap <Leader>se :UltiSnipsEdit<CR>
nnoremap <Leader>so :so %<CR>
nnoremap <Leader>ss :w !sudo tee %<CR>
nnoremap <Leader>t= :Tabularize /=<CR>
nnoremap <Leader>t\| :Tabularize /\|<CR>
nnoremap <Leader>tw :%s/\s\+$//<CR><C-o>
nnoremap <Leader>V :so $MYVIMRC<CR>
nnoremap <Leader>v :vsplit $MYVIMRC<CR>
vnoremap <Leader>t= :Tabularize /=<CR>
vnoremap <Leader>t\| :Tabularize /\|<CR>
