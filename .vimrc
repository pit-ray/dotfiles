"encoding
set nocompatible
set encoding=utf-8
set fileencodings=utf-8
scriptencoding

let mapleader = "\<space>"
let $VIMHOME = $HOME . (has('win32') ? '/vimfiles' : '/.vim')
if empty(glob($VIMHOME . '/autoload/plug.vim'))
    exe('term curl -fLo ' . $VIMHOME . '/autoload/plug.vim --create-dirs https://raw.github.com/junegunn/vim-plug/master/plug.vim')
    autocmd VimEnter * PlugInstall --sync | so $MYVIMRC
endif

call plug#begin($VIMHOME . '/plugged')
Plug 'cespare/vim-toml', {'for': 'toml'}
Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/vim-easy-align'
Plug 'mattn/emmet-vim', {'for': 'html'}
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/vim-lsp'
Plug 'sakhnik/nvim-gdb', {'for': ['c', 'cpp']}
Plug 'simeji/winresizer'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
Plug 'vhdirk/vim-cmake', {'for': ['c', 'cpp']}
Plug 'vim-airline/vim-airline'
Plug 'vim-scripts/nsis.vim', {'for': ['nsi', 'in']}
call plug#end()

command! Update so<space>$MYVIMRC | PlugInstall

"vim-lsp
let g:lsp_diagnostics_echo_cursor = 1

"vim-lsp-settings
let g:lsp_settings_servers_dir = $VIMHOME . '/vim-lsp-settings/servers'
command! Def sp | LspDefinition
command! Dec sp | LspDeclaration

"vim-vinegar
"let g:NERDTreeHijackNetrw = 0

"ctrlp
let g:ctrlp_working_path_mode = 'ra'

"vim-easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
command! -range Eqga <line1>,<line2>EasyAlign<Space>-=

"scheme
if empty(glob($VIMHOME . '/colors/hybrid.vim'))
    exe('term curl -fLo ' . $VIMHOME . '/colors/hybrid.vim --create-dirs https://raw.githubusercontent.com/w0ng/vim-hybrid/master/colors/hybrid.vim')
endif
syntax enable
set background=dark
if has('gui_running')
    if has('syntax')
        autocmd Colorscheme * highlight FullWidthSpace term=underline ctermbg=DarkGreen guibg=DarkGreen
        autocmd VimEnter,WinEnter * match FullWidthSpace /　/
    endif
    colorscheme hybrid
else
    let g:hybrid_custom_term_colors = 1
    let g:hybrid_reduced_contrast   = 1
    colorscheme hybrid
endif

set hlsearch
set showmatch
set ruler
set number
set showcmd
set list "show invisible char
set listchars=tab:>-,trail:. "tab - space .
set lines=32
set columns=128

"disable gui toolbar and menubar
set guioptions-=m
set guioptions-=T
set guifont=Consolas:h10

"indent
filetype plugin indent on
set autoindent
set expandtab
set tabstop=4
set shiftwidth=4
set backspace=2
"set foldmethod=indent

"other
set nowrapscan
set nowrap

set nobackup
set noswapfile
set backspace=indent,eol,start
set clipboard=unnamed,autoselect
set wildmenu
set wildmode=list:longest,full

"infinity undo
set undodir=$VIMHOME

"bindings
noremap <c-h> <c-w><c-h>
noremap <c-j> <c-w><c-j>
noremap <c-k> <c-w><c-k>
noremap <c-l> <c-w><c-l>
command! Termp terminal powershell
