call plug#begin('~/.vim/plugged')

Plug 'PProvost/vim-ps1'
Plug 'chriskempson/base16-vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'elixir-editors/vim-elixir'
Plug 'fatih/vim-go'
Plug 'leafgarland/typescript-vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
Plug 'mhinz/vim-mix-format'
Plug 'neovimhaskell/haskell-vim'
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'valloric/youcompleteme'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-syntastic/syntastic'

call plug#end()

set autoread
set background=dark
set backspace=2
set colorcolumn=120
set conceallevel=0
set encoding=utf-8
set expandtab
set fileencoding=utf-8
set fileformat=unix
set laststatus=2
set modeline
set modelines=5
set nobackup
set nofsync
set noswapfile
set nowritebackup
set number
set shiftround
set shiftwidth=4
set smartindent
set softtabstop=4
set swapsync=
set tabstop=4

if filereadable(expand("~/.vimrc_background"))
    let base16colorspace=256
    source ~/.vimrc_background
endif

let g:airline_powerline_fonts=0
let g:airline_symbols_ascii=1
let g:airline_theme='base16'
let g:ctrlp_custom_ignore='\v\.(o|so|bin|elf)$'
let g:go_fmt_command="goimports"
let g:mix_format_on_save=1
let g:mix_format_silent_errors=0
let g:rust_fold=0
let g:rustfmt_autosave=0
let g:syntastic_always_populate_loc_list=1
let g:syntastic_asm_compiler="nasm"
let g:ycm_always_populate_location_list=1
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_global_ycm_extra_conf='~/.vim/.ycm_extra_conf.py'
let g:ycm_key_list_previous_completion=['<c-p>', '<up>']
let g:ycm_key_list_select_completion=['<c-n>', '<down>']
let g:ycm_min_num_of_chars_for_completion=1
let g:ycm_rust_src_path="/home/master/.multirust/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src"

let mapleader=" "

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
nnoremap <leader>en     :lnext<CR>
nnoremap <leader>ep     :lprev<CR>
nnoremap <leader>li     :set invlist<CR>
nnoremap <leader>mk     :make<CR>
nnoremap <leader>nt     :NERDTreeToggle<CR>
nnoremap <leader>pa     :set invpaste<CR>
nnoremap <leader>so     :so %<CR>
nnoremap <leader>tb     :TagbarToggle<CR>
nnoremap <leader>vi     :vsplit $MYVIMRC<CR>
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

autocmd BufEnter * :call QuitIfOnlyNERDTree()
autocmd BufWrite * :call RemoveTrailingWhiteSpace()
autocmd FileType help,man wincmd L
autocmd FileType qf wincmd J
autocmd BufReadPost qf nnoremap <buffer> <CR> <CR>
autocmd BufRead,BufNewFile *.asm set filetype=nasm

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
