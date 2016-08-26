call plug#begin('~/.vim/plugged')

Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Yggdroot/indentLine'

Plug 'SirVer/ultisnips'
Plug 'majutsushi/tagbar'
Plug 'godlygeek/tabular'
Plug 'raimondi/delimitmate'

Plug 'ctrlpvim/ctrlp.vim', { 'on': 'CtrlP' }
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

Plug 'fatih/vim-go', { 'for': 'go' }

function! BuildYCM(info)
    if a:info.status == "installed" || a:info.force
        !./install.py --clang-completer --gocode-completer
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
set conceallevel=2

""" Identation
set smartindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set shiftround

""" Looks
set number
set background=dark
let g:solarized_termcolors=256
colorscheme solarized
set colorcolumn=120
set laststatus=2
let g:airline_theme='solarized'
let g:indentLine_color_term = 239

""" Keys
set backspace=2
let mapleader=" "

nnoremap <leader>li     :set invlist<CR>
nnoremap <leader>nt     :NERDTreeToggle<CR>
nnoremap <leader>pa     :set invpaste<CR>
nnoremap <leader>so     :so %<CR>
nnoremap <leader>sn     :UltiSnipsEdit<CR>
nnoremap <leader>tb     :TagbarToggle<CR>
nnoremap <leader>vi     :vsplit $MYVIMRC<CR>
nnoremap <leader>t\|    :Tabularize /\|<CR>
nnoremap <leader>bp     :echo eval(line2byte(line("."))+col("."))<CR>

vnoremap <leader>t\|    :Tabularize /\|<CR>


""" Hooks
autocmd BufWrite * :call RemoveTrailingWhiteSpace()
autocmd FileType help,man wincmd L

""" UltiSnips
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetsDir="~/.vim/UltiSnips"
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

function! <SID>ExpandSnippetOrReturn()
    let snippet = UltiSnips#ExpandSnippetOrJump()
    if g:ulti_expand_or_jump_res > 0
        return snippet
    else
        return "\<CR>"
    endif
endfunction

inoremap <expr> <CR> pumvisible() ? "<C-R>=<SID>ExpandSnippetOrReturn()<CR>" : "\<CR>"

""" YouCompleteMe
let g:ycm_global_ycm_extra_conf='~/.vim/.ycm_extra_conf.py'
let g:ycm_min_num_of_chars_for_completion=1
let g:ycm_key_list_select_completion = ['<tab>', '<down>']
let g:ycm_key_list_previous_completion = ['<s-tab>', '<up>']
let g:ycm_autoclose_preview_window_after_completion=1

""" Go
let g:go_fmt_command = "goimports"
au FileType go nmap <leader>gb :GoBuild<CR>
au FileType go nmap <leader>gc :GoCoverage<CR>
au FileType go nmap <leader>gd :GoDoc<CR>
au FileType go nmap <leader>ge :GoRename<CR>
au FileType go nmap <leader>gi :GoInfo<CR>
au FileType go nmap <leader>gl :GoLint<CR>
au FileType go nmap <leader>gr :GoRun<CR>
au FileType go nmap <leader>gs :GoImplementss<CR>
au FileType go nmap <leader>gt :GoTest<CR>
au FileType go nmap <leader>gv :GoVet<CR>
au FileType go nmap <leader>gw :GoDocBrowser<CR>

""" Funcs
function! RemoveTrailingWhiteSpace()
    execute "normal mz"
        %s/\s\+$//ge
    execute "normal `z"
endfunction
