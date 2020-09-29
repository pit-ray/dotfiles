if &compatible
    set nocompatible
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
    call dein#begin('~/.cache/dein')
    call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

  if !has('nvim')
      call dein#load_toml('~/dein.toml')
  endif

    call dein#end()
    call dein#save_state()
endif


"encoding
set encoding=utf-8
scriptencoding
set fileencodings=utf-8

"scheme
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
    let g:hybrid_reduced_contrast = 1
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
set nobackup
set noswapfile
set backspace=indent,eol,start
set clipboard=unnamed,autoselect
set wildmenu
set wildmode=list:longest,full

"infinity undo
set undodir=%USERPROFILE%/vimfiles/

set guifont=Consolas:h10
set nowrap

"bindings
noremap <c-h> <c-w><c-h>
noremap <c-j> <c-w><c-j>
noremap <c-k> <c-w><c-k>
noremap <c-l> <c-w><c-l>

command! Termp terminal powershell
