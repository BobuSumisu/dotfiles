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
NeoBundle 'SirVer/ultisnips'
NeoBundle 'godlygeek/tabular'
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'Valloric/YouCompleteMe', { 'build': { 'unix': './install.sh --clang-completer --system-libclang' } }

NeoBundle '~/projects/vim/i3'

call neobundle#end()
NeoBundleCheck

runtime! ftplugin/man.vim

if has('autocmd')
  filetype plugin indent on
endif

if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

""" File options
set fileformat=unix
set fileencoding=utf-8
set encoding=utf-8
set nobackup
set noswapfile
set nowritebackup
set autoread
set swapsync=
set nofsync
set modeline
set modelines=5

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
set conceallevel=0

""" UltiSnips
let g:UltiSnipsExpandTrigger                = '<C-j>'
let g:UltiSnipsJumpForwardTrigger           = '<tab>'
let g:UltiSnipsJumpBackwardTrigger          = '<s-tab>'
let g:UltiSnipsEditSplit                    = "vertical"

""" YouCompleteMe
let g:ycm_min_num_of_chars_for_completion   = 1
let g:ycm_filetype_blacklist                = { }
let g:ycm_global_ycm_extra_conf             ='~/.vim/.ycm_extra_conf.py'

""" Keys
let mapleader=" "
nnoremap <Leader>cm     :!chmod +x %<CR>
nnoremap <Leader>jd     :YcmCompleter GoTo<CR>
nnoremap <Leader>l      :set list<CR>
nnoremap <Leader>L      :set nolist<CR>
nnoremap <Leader>mc     :make! clean<CR>
nnoremap <Leader>mm     :make!<CR>
nnoremap <Leader>n      :NERDTree<CR>
nnoremap <Leader>N      :NERDTreeClose<CR>
nnoremap <Leader>P      :set nopaste<CR>
nnoremap <Leader>p      :set paste<CR>
nnoremap <Leader>se     :UltiSnipsEdit<CR>
nnoremap <Leader>so     :so %<CR>
nnoremap <Leader>ss     :w !sudo tee %<CR>
nnoremap <Leader>t=     :Tabularize /=<CR>
nnoremap <Leader>t\|    :Tabularize /\|<CR>
nnoremap <Leader>V      :so $MYVIMRC<CR>
nnoremap <Leader>v      :vsplit $MYVIMRC<CR>
vnoremap <Leader>t=     :Tabularize /=<CR>
vnoremap <Leader>t\|    :Tabularize /\|<CR>
nnoremap <Leader>x      :!./%<CR>

""" Hooks
autocmd BufWrite * :call RemoveTrailingWhiteSpace()
autocmd FileType help wincmd L
autocmd FileType man wincmd L
autocmd FileType * setlocal conceallevel=0
autocmd VimEnter,BufEnter,BufNewFile,BufRead * set conceallevel=0
autocmd CompleteDone * pclose

""" Funcs
function! RemoveTrailingWhiteSpace()
    execute "normal mz"
    %s/\s\+$//ge
    execute "normal 'z"
endfunction
