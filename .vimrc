call plug#begin('~/.vim/plugged')

Plug 'altercation/vim-colors-solarized'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ctrlpvim/ctrlp.vim'

Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/seoul256.vim'

Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'PProvost/vim-ps1'

""" YouCompleteMe has to be rebuilt on update.

function! BuildYCM(info)
    if a:info.status == "installed" || a:info.force
        !./install.py --clang-completer --gocode-completer --racer-completer
    endif
endfunction

Plug 'valloric/youcompleteme', { 'do': function('BuildYCM') }

call plug#end()

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
set conceallevel=0

""" Identation
set smartindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set shiftround

""" Looks
set t_Co=256
set number
set colorcolumn=120
set laststatus=2
let g:indentLine_color_term = 239
set background=dark
let g:solarized_termcolors=16
silent! colorscheme solarized

""" Airline
let g:airline_powerline_fonts = 0
let g:airline_symbols_ascii = 1
let g:airline_theme='solarized'

""" Limelight
let g:limelight_conceal_ctermfg = "10/7"    " base01
let g:limelight_conceal_guifg = "#586e75"
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

""" Keys
set backspace=2
let mapleader=" "

""" Faster movement between splits.
nnoremap <c-j>          <c-w><c-j>
nnoremap <c-k>          <c-w><c-k>
nnoremap <c-h>          <c-w><c-h>
nnoremap <c-l>          <c-w><c-l>

""" Some general keybindings.
nnoremap <leader>bp     :echo eval(line2byte(line("."))+col("."))<CR>
nnoremap <leader>li     :set invlist<CR>
nnoremap <leader>mk     :make<CR>
nnoremap <leader>nt     :NERDTreeToggle<CR>
nnoremap <leader>pa     :set invpaste<CR>
nnoremap <leader>so     :so %<CR>
nnoremap <leader>vi     :vsplit $MYVIMRC<CR>
nnoremap <leader>gy     :Goyo<CR>
nnoremap <leader>ll     :Limelight!!<CR>

""" Hooks
" autocmd VimEnter * :call OpenNERDTree()
autocmd BufEnter * :call QuitIfOnlyNERDTree()
autocmd BufWrite * :call RemoveTrailingWhiteSpace()
autocmd FileType help,man wincmd L
autocmd FileType qf wincmd J
autocmd BufReadPost qf nnoremap <buffer> <CR> <CR>

""" YouCompleteMe
let g:ycm_global_ycm_extra_conf='~/.vim/.ycm_extra_conf.py'
let g:ycm_min_num_of_chars_for_completion=1
let g:ycm_key_list_select_completion = ['<c-n>', '<down>']
let g:ycm_key_list_previous_completion = ['<c-p>', '<up>']
let g:ycm_autoclose_preview_window_after_completion=1
nnoremap <leader>yd     :YcmCompleter GetDoc<CR>
nnoremap <leader>yf     :YcmCompleter FixIt<CR>
nnoremap <leader>yg     :YcmCompleter GoTo<CR>
nnoremap <leader>yi     :YcmCompleter GoToInclude<CR>
nnoremap <leader>yr     :YcmCompleter RestartServer<CR>
nnoremap <leader>yt     :YcmCompleter GetType<CR>
nnoremap <leader>yx     :YcmCompleter GoToReferences<CR>

""" Go
let g:go_fmt_command = "goimports"
au FileType go nmap <leader>gb      :GoBuild<CR>
au FileType go nmap <leader>gc      :GoCoverageToggle<CR>
au FileType go nmap <leader>gd      :GoDoc<CR>
au FileType go nmap <leader>ge      :GoRename<CR>
au FileType go nmap <leader>gf      :GoDef<CR>
au FileType go nmap <leader>gi      :GoInfo<CR>
au FileType go nmap <leader>gl      :GoLint<CR>
au FileType go nmap <leader>gn      :GoTestFunc<CR>
au FileType go nmap <leader>gr      :GoRun<CR>
au FileType go nmap <leader>gs      :GoImplements<CR>
au FileType go nmap <leader>gt      :GoTest<CR>
au FileType go nmap <leader>gv      :GoVet<CR>
au FileType go nmap <leader>gw      :GoDocBrowser<CR>

""" Rust
let g:ycm_rust_src_path = "/home/master/.multirust/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src"
let g:rustfmt_autosave = 0
let g:rust_fold = 0
au FileType rust nmap <leader>cb    :!cargo build<CR>
au FileType rust nmap <leader>cc    :!cargo clean<CR>
au FileType rust nmap <leader>cd    :!cargo doc<CR>
au FileType rust nmap <leader>ch    :!cargo bench<CR>
au FileType rust nmap <leader>cr    :!cargo run<CR>
au FileType rust nmap <leader>ct    :!cargo test<CR>
au FileType rust nmap <leader>cu    :!cargo update<CR>
au FileType rust nmap <leader>ra    :RustEmitAsm<CR>
au FileType rust nmap <leader>re    :RustExpand<CR>
au FileType rust nmap <leader>ri    :RustEmitIr<CR>
au FileType rust nmap <leader>rr    :RustRun<CR>

""" Funcs
function! OpenNERDTree()
    NERDTree
    if argc() != 0
        exe "normal \<C-W>\<C-L>"
    endif
endfunction

function! QuitIfOnlyNERDTree()
    if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree())
        quit
    endif
endfunction

function! RemoveTrailingWhiteSpace()
    execute "normal mz"
        %s/\s\+$//ge
    execute "normal `z"
endfunction
