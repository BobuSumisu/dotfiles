" ~/.vimrc

call plug#begin('~/.vim/plugged')
Plug 'arcticicestudio/nord-vim'
Plug 'fatih/vim-go',                        { 'for': 'go', 'do': ':GoInstallBinaries' }
Plug 'itchyny/lightline.vim'
Plug 'jsfaint/gen_tags.vim'
Plug 'junegunn/fzf',                        { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim',                   { 'on': 'Goyo' }
Plug 'junegunn/limelight.vim',              { 'on': 'Limelight' }
Plug 'junegunn/vader.vim',                  { 'on': 'Vader', 'for': 'vader' }
Plug 'leafgarland/typescript-vim',          { 'for': 'typescript' }
Plug 'majutsushi/tagbar',                   { 'on': 'TagbarToggle' }
Plug 'mengelbrecht/lightline-bufferline'
Plug 'ncm2/ncm2'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-gtags'
Plug 'ncm2/ncm2-jedi',                      { 'for': 'python' }
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-pyclang',                   { 'for': [ 'c', 'cpp' ] }
Plug 'ncm2/ncm2-racer',                     { 'for': 'rust' }
Plug 'pangloss/vim-javascript',             { 'for': 'javascript' }
Plug 'rhysd/vim-crystal',                   { 'for': 'crystal' }
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'rust-lang/rust.vim',                  { 'for': 'rust' }
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree',                 { 'on':  'NERDTreeToggle' }
Plug 'SirVer/ultisnips'
Plug 'tikhomirov/vim-glsl',                 { 'for': 'glsl' }
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'
call plug#end()

""" Editor configuration


" Setting the preferred cursor style is easy and fun...
if exists('$TMUX')
    let &t_SI .= "\<Esc>Ptmux;\<Esc>\<Esc>[5 q\<Esc>\\"
    let &t_EI .= "\<Esc>Ptmux;\<Esc>\<Esc>[2 q\<Esc>\\"
    augroup cursorcleanup
        autocmd!
        autocmd VimLeave * silent !echo -ne "\033Ptmux;\033\033[2 q\033\\"
    augroup end
else
    let &t_SI .= "\<Esc>[5 q"
    let &t_EI .= "\<Esc>[2 q"
    augroup cursorcleanup
        autocmd!
        autocmd VimLeave * silent !echo -ne "\033[2 q"
    augroup end
endif

silent! colorscheme nord                    " Using nord color theme from plugin.
set autoindent                              " Copy indent from current line when starting a new line.
set autoread                                " Automatically read when file changed outside vim.
set background=dark                         " Adjust colors to a dark background.
set backspace=indent,eol,start              " Change how <BS> etc. work in insert mode.
set colorcolumn=+1                          " Color column at textwidth+1.
set completeopt=noinsert,menuone,noselect   " Options for ins-completion.
set expandtab                               " Use spaces in indents.
set hlsearch                                " Highlight search matches.
set ignorecase                              " Ignore case in search patterns.
set incsearch                               " Show matches while typing.
set laststatus=2                            " Alway show a status line.
set list                                    " Turn on list mode: show tabs, trailing spaces and nbsps.
set listchars=tab:>-,trail:-,nbsp:?         " Characters in list mode.
set modeline                                " Use modeline (default off in Debian?).
set noswapfile                              " Disable swap file.
set nrformats=alpha,bin,hex                 " Number bases for CTRL-A and CTRL-X.
set number                                  " Show line numbers.
set ruler                                   " Show line and column number.
set shiftround                              " Round indent to multiple of 'shiftwidth'.
set shiftwidth=4                            " Numbers of spaces to use for each step of (auto)indent.
set shortmess+=c                            " Don't show ins-completion messages.
set showmatch                               " Show matching brackets by briefly jumping to it.
set showtabline=2                           " Always show tab line.
set smartcase                               " Override 'ignorecase' in searches if it contains upper case characters.
set smartindent                             " Smart autoindenting.
set smarttab                                " Smart tab in front of a line.
set softtabstop=4                           " Number of spaces that <Tab> counts for in editing operations.
set tabstop=4                               " Number of spaces that <Tab> counts for.
set textwidth=119                           " Maximum width of text that is being inserted.
set timeout                                 " Turn on timeout on mappings and key codes.
set timeoutlen=500                          " Timeout on mappings and key codes in ms.
set ttimeout                                " Turn on timeout on key codes.
set ttimeoutlen=100                         " Timeout on key codes in ms.
set wildmenu                                " Command-line completion in enhanced mode.

""" Plugin configuration

let g:ale_c_clang_options           = '-std=gnu11 -Wall -Wextra -Werror -Wpedantic'
let g:ale_c_gcc_options             = '-std=gnu11 -Wall -Wextra -Werror -Wpedantic'
let g:ale_c_parse_makefile          = 1
let g:ale_cpp_clang_options         = '-std=c++1z -Wall -Wextra -Wpedantic'
let g:ale_fix_on_save               = 1
let g:ale_fixers                    = { '*': ['remove_trailing_lines', 'trim_whitespace'] }
let g:ale_lint_on_text_changed      = 0
let g:asmsyntax                     = 'nasm'
let g:fzf_command_prefix            = 'Fzf'
let g:go_fmt_command                = 'goimports'
let g:lightline                     = {}
let g:lightline.active              = { 'left': [ [ 'mode', 'paste' ], [ 'gitbranch', 'readonly', 'filename', 'modified' ] ] }
let g:lightline.colorscheme         = 'nord'
let g:lightline.component           = { 'progname': v:progname . ' ' . v:version }
let g:lightline.component_expand    = { 'buffers': 'lightline#bufferline#buffers' }
let g:lightline.component_function  = { 'gitbranch': 'fugitive#head' }
let g:lightline.component_type      = { 'buffers': 'tabsel' }
let g:lightline.tabline             = { 'left': [ [ 'buffers' ] ], 'right': [ [ 'progname' ] ] }
let g:limelight_conceal_ctermfg     = 'black'
let g:mapleader                     = ' '
let g:ncm2_pyclang#library_path     = '/usr/lib/llvm-7/lib/libclang.so.1'
let g:NERDSpaceDelims               = 1
let g:rustfmt_autosave              = 1
let g:termdebug_wide                = 120
let g:UltiSnipsEditSplit            = 'vertical'
let g:UltiSnipsExpandTrigger        = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger  = '<s-tab>'
let g:UltiSnipsJumpForwardTrigger   = '<tab>'
let g:UltiSnipsSnippetDirectories   = [$HOME.'/.vim/UltiSnips']

""" Key bindings

inoremap jj                 <Esc>
nnoremap <C-h>              <C-w><C-h>
nnoremap <C-j>              <C-w><C-j>
nnoremap <C-k>              <C-w><C-k>
nnoremap <C-l>              <C-w><C-l>
nnoremap ss                 :w<CR>
nnoremap <C-b>              :FzfBuffers<CR>
nnoremap <C-p>              :FzfFiles<CR>
nnoremap <leader><Space>    :noh<CR>
nnoremap <leader>go         :Goyo<CR>
nnoremap <leader>li         :set invlist<CR>
nnoremap <leader>nt         :NERDTreeToggle<CR>
nnoremap <leader>pa         :set invpaste<CR>
nnoremap <leader>so         :so %<CR>
nnoremap <leader>tb         :TagbarToggle<CR>
nnoremap <leader>us         :UltiSnipsEdit<CR>
nnoremap <leader>vi         :vsplit ~/.vimrc<CR>
nnoremap <leader>vl         :VimuxRunLastCommand<CR>
nnoremap <leader>vp         :VimuxPromptCommand<CR>
nnoremap <leader>vs         :VimuxInspectRunner<CR>
nnoremap <leader>vz         :VimuxZoomRunner<CR>
nnoremap <S-t>              :FzfTags<CR>

""" Autocommands

augroup init
    autocmd!
    autocmd BufEnter * call ncm2#enable_for_buffer()
    autocmd BufNewFile,BufRead *.go set nolist
    autocmd BufNewFile,BufRead *.vs,*.fs set filetype=glsl
    autocmd FileType c,cpp nnoremap <buffer> gd :<c-u>call ncm2_pyclang#goto_declaration()<cr>
    autocmd FileType qf wincmd J
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
    autocmd User GoyoEnter Limelight
    autocmd User GoyoLeave Limelight!
augroup END

command! W w

if has('packloadall')
    packloadall
    silent! helptags ALL
endif
