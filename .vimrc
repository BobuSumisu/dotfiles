" ~/.vimrc
scriptencoding utf-8

if !exists('$TMUX')
    echo "Warning: you are not in tmux :)"
endif

""" Plugins {{{

call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'                                              " Pretty colors.
Plug 'itchyny/lightline.vim'                                        " Simple statusline.

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }   " Getting fuzzy.
Plug 'junegunn/fzf.vim'

Plug 'jsfaint/gen_tags.vim'                                         " Simple tags autogeneration.

Plug 'neoclide/coc.nvim', {'branch': 'release'}                     " Conqueror of Completion!

Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'                 " Get me some snippets.

Plug 'tikhomirov/vim-glsl', { 'for': 'glsl' }                       " For OpenGL Shader Language.
Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoInstallBinaries' }    " For Go.
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }             " For Javascript.
Plug 'rhysd/vim-crystal', { 'for': 'crystal' }                      " For Crystal.
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }          " For Typescript.
Plug 'rust-lang/rust.vim', { 'for': 'rust' }                        " For Rust.
Plug 'mattn/emmet-vim'                                              " For fast HTML/CSS.

Plug 'tpope/vim-endwise'                                            " Automatic insertions of different 'end's.
Plug 'tpope/vim-fugitive'                                           " The one and only Git wrapper for vim.
Plug 'tpope/vim-repeat'                                             " For using . with plugin maps.
Plug 'tpope/vim-surround'                                           " For better editing of surrounded stuff.
Plug 'tpope/vim-unimpaired'                                         " Some smart paired mappings.
Plug 'tpope/vim-commentary'                                         " Comment stuff out.

call plug#end()

" }}}

""" Editor configuration {{{

silent! colorscheme gruvbox
set autoindent                              " Copy indent from current line when starting a new line.
set autoread                                " Automatically read when file changed outside vim.
set background=dark                         " Adjust colors to a dark background.
set backspace=indent,eol,start              " Change how <BS> etc. work in insert mode.
set cmdheight=2                             " A little larger command window.
set colorcolumn=+1                          " Color column at textwidth+1.
set completeopt=noinsert,menuone,noselect   " Options for ins-completion.
set expandtab                               " Use spaces in indents.
set hidden                                  " Required by CoC.
set hlsearch                                " Highlight search matches.
set ignorecase                              " Ignore case in search patterns.
set incsearch                               " Show matches while typing.
set laststatus=2                            " Alway show a status line.
set list                                    " Turn on list mode: show tabs, trailing spaces and nbsps.
set listchars=tab:>-,trail:-,nbsp:?         " Characters in list mode.
set modeline                                " Use modeline (default off in Debian?).
set nobackup                                " No backup.
set noswapfile                              " Disable swap file.
set nowritebackup                           " Don't backup on write.
set nrformats=alpha,bin,hex                 " Number bases for CTRL-A and CTRL-X.
set number                                  " Show line numbers.
set ruler                                   " Show line and column number.
set signcolumn=yes                          " Always show the sign column.
set shiftround                              " Round indent to multiple of 'shiftwidth'.
set shiftwidth=4                            " Numbers of spaces to use for each step of (auto)indent.
set shortmess+=c                            " Don't show ins-completion messages.
set showmatch                               " Show matching brackets by briefly jumping to it.
set showtabline=0                           " Always show tab line.
set smartcase                               " Override 'ignorecase' in searches if it contains upper case characters.
set smartindent                             " Smart autoindenting.
set smarttab                                " Smart tab in front of a line.
set softtabstop=4                           " Number of spaces that <Tab> counts for in editing operations.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
set tabstop=4                               " Number of spaces that <Tab> counts for.
set textwidth=119                           " Maximum width of text that is being inserted.
set timeout                                 " Turn on timeout on mappings and key codes.
set timeoutlen=500                          " Timeout on mappings and key codes in ms.
set ttimeout                                " Turn on timeout on key codes.
set ttimeoutlen=100                         " Timeout on key codes in ms.
set updatetime=300                          " Think I need this for the CursorHold autocommand event and CoC.
set wildmenu                                " Command-line completion in enhanced mode.

" }}}

""" Plugin configuration {{{

let g:asmsyntax                     = 'nasm'
let g:coc_snippet_next              = '<tab>'
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
let g:lightline                     = {}
let g:lightline.active              = { 'left': [ [ 'mode', 'paste' ], [ 'gitbranch', 'readonly', 'filename', 'modified' ] ] }
let g:lightline.colorscheme         = 'gruvbox'
let g:lightline.component_function  = { 'gitbranch': 'fugitive#head' }
let g:limelight_conceal_ctermfg     = 'black'
let g:rustfmt_autosave              = 1
let g:termdebug_wide                = 120
let g:UltiSnipsEditSplit            = 'vertical'

""" }}}

""" Key bindings {{{

let g:mapleader = ' '

inoremap jk                 <Esc>
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
nnoremap <leader>ws         :TrimWhitespace<CR>
nnoremap <S-t>              :FzfTags<CR>

nmap ø [
nmap æ ]
omap ø [
omap æ ]
xmap ø [
xmap æ ]

" Remap tab in insert mode to support CoC completion and coc-snippets.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

inoremap <silent><expr> <c-space>       coc#refresh()
nmap <silent>           [g              <Plug>(coc-diagnostic-prev)
nmap <silent>           ]g              <Plug>(coc-diagnostic-next)
nmap <silent>           gd              <Plug>(coc-definition)
nmap <silent>           gy              <Plug>(coc-type-definition)
nmap <silent>           gi              <Plug>(coc-implementation)
nmap <silent>           gr              <Plug>(coc-references)
nnoremap <silent>       K               :call <SID>show_documentation()<CR>

nmap                    <leader>rn      <Plug>(coc-rename)
xmap                    <leader>f       <Plug>(coc-format-selected)
nmap                    <leader>f       <Plug>(coc-format-selected)
xmap                    <leader>a       <Plug>(coc-codeaction-selected)
nmap                    <leader>a       <Plug>(coc-codeaction-selected)
nmap                    <leader>ac      <Plug>(coc-codeaction)
nmap                    <leader>qf      <Plug>(coc-fix-current)
xmap                    if              <Plug>(coc-funcobj-i)
xmap                    af              <Plug>(coc-funcobj-a)
omap                    if              <Plug>(coc-funcobj-i)
omap                    af              <Plug>(coc-funcobj-a)
nmap <silent>           <C-d>           <Plug>(coc-range-select)
xmap <silent>           <C-d>           <Plug>(coc-range-select)

nnoremap <silent>       <space>a        :<C-u>CocList diagnostics<cr>
nnoremap <silent>       <space>e        :<C-u>CocList extensions<cr>
nnoremap <silent>       <space>c        :<C-u>CocList commands<cr>
nnoremap <silent>       <space>o        :<C-u>CocList outline<cr>
nnoremap <silent>       <space>s        :<C-u>CocList -I symbols<cr>
nnoremap <silent>       <space>j        :<C-u>CocNext<CR>
nnoremap <silent>       <space>k        :<C-u>CocPrev<CR>
nnoremap <silent>       <space>p        :<C-u>CocListResume<CR>


""" }}}

""" Autocommands {{{

augroup init
    autocmd!
    autocmd BufNewFile,BufRead *.go set nolist
    autocmd BufNewFile,BufRead *.vs,*.fs set filetype=glsl
    autocmd CompleteDone * pclose
    autocmd FileType qf wincmd J
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
    autocmd CursorHold * silent call CocActionAsync('highlight')
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup END

""" }}}

""" Commands {{{

command! W w
command! -nargs=0 Format            :call CocAction('format')
command! -nargs=? Fold              :call CocAction('fold', <f-args>)
command! -nargs=0 OR                :call CocAction('runCommand', 'editor.action.organizeImport')
command! -nargs=0 TrimWhitespace    :call s:trim_whitespace()

""" }}}

""" Functions {{{

function! s:trim_whitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfunction

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

""" }}}

""" Packages {{{

if has('packloadall')
    packloadall
    silent! helptags ALL
endif

""" }}}

" vim: set foldmethod=marker:
