set encoding=utf-8
set fileformats=unix,dos,mac
set nocompatible
set fileencodings=utf-8,cp932,euc-jp,iso-20220-jp,default,latin
scriptencoding

"enable dgb debugger
packadd termdebug

let mapleader = "\<space>"
let $VIMHOME = $HOME . (has('win32') ? '/vimfiles' : '/.vim')
if empty(glob($VIMHOME . '/autoload/plug.vim'))
    exe('term curl -fLo ' . $VIMHOME . '/autoload/plug.vim --create-dirs https://raw.github.com/junegunn/vim-plug/master/plug.vim')
    au! VimEnter * PlugInstall --sync | so $MYVIMRC
endif

call plug#begin($VIMHOME . '/plugged')
Plug 'skywind3000/asyncrun.vim'
Plug 'cespare/vim-toml', {'for': 'toml'}
Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/vim-easy-align'
Plug 'mattn/emmet-vim', {'for': 'html'}
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'simeji/winresizer'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
Plug 'vhdirk/vim-cmake', {'for': ['c', 'cpp']}
Plug 'vim-airline/vim-airline'
Plug 'vim-scripts/nsis.vim', {'for': ['nsi', 'in']}
call plug#end()

command! Update so<space>$MYVIMRC | PlugInstall
command! So so<space>$MYVIMRC

"Options---------------------
"vim-lsp
let g:lsp_diagnostics_echo_cursor = 1

"vim-lsp-settings
let g:lsp_settings_root_markers = ['.git']
let g:lsp_settings_servers_dir  = $VIMHOME . '/vim-lsp-settings/servers'
command! Def sp | LspDefinition
command! Dec sp | LspDeclaration

"vim-vinegar
let g:NERDTreeHijackNetrw = 0

"ctrlp
let g:ctrlp_working_path_mode = 'ra'

"vim-easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
command! -range Eqga <line1>,<line2>EasyAlign<Space>-=

"------------------
"scheme
if empty(glob($VIMHOME . '/colors/hybrid.vim'))
    exe('term curl -fLo ' . $VIMHOME . '/colors/hybrid.vim --create-dirs https://raw.githubusercontent.com/w0ng/vim-hybrid/master/colors/hybrid.vim')
endif
syntax enable
set background=dark
if has('gui_running')
    if has('syntax')
        au! Colorscheme * highlight FullWidthSpace term=underline ctermbg=DarkGreen guibg=DarkGreen
        au! VimEnter,WinEnter * match FullWidthSpace /　/
    endif
else
    let g:hybrid_custom_term_colors = 1
    let g:hybrid_reduced_contrast   = 1
endif
colorscheme hybrid

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
set guifont=Consolas:h8

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

set novb t_vb=

"infinity undo
set undodir=$VIMHOME

"My bindings
noremap <c-h> <c-w><c-h>
noremap <c-j> <c-w><c-j>
noremap <c-k> <c-w><c-k>
noremap <c-l> <c-w><c-l>

if has('terminal')
    tnoremap <c-h> <c-w><c-h>
    tnoremap <c-j> <c-w><c-j>
    tnoremap <c-k> <c-w><c-k>
    tnoremap <c-l> <c-w><c-l>
endif

if has('win32')
    set shell=powershell
endif

let g:termdebug_use_prompt = 0
noremap <leader>b :Break<cr>
noremap <f5> :Continue<cr>
noremap <leader>e :Evaluate<cr>
noremap <leader>g :Gdb<cr>
noremap <leader>s :Step<cr>
noremap <leader>o :Over<cr>
noremap <leader>q :Gdb<cr><esc>iquit<cr>
noremap <leader>r :Run<cr><esc>:Source<cr>

"My functions ---------------------------
let g:previous_word_under_cursor = ''
function! EvaluateUnderCursor() abort
    if exists(':Evaluate')
        let l:word = expand('<cword>')
        if !empty(l:word) && l:word != ' '
            if g:previous_word_under_cursor != l:word
                Evaluate
                let g:previous_word_under_cursor = l:word
            endif
        endif
    endif
endfunction

set updatetime=700
au! CursorHold * call EvaluateUnderCursor()


"Utilities --------------------------------
function! StartNewLineWithRemoveSP() abort
    let l:startcol = col('.')
    normal w
    let l:spnum = col('.') - l:startcol - 1
    if l:spnum > 0
        for a in range(l:spnum)
            normal X
        endfor
    endif
    execute "normal i\<cr>\<esc>"
endfunction

"In C/C++
"[from] void myfunction(int a, int b) ;
"[to]   void myfunction(
"           int a,
"           int b) ;
function! AlignArgs() abort
    let l:startq = '('
    let l:endq   = ')'
    let l:delim  = ','

    call cursor(0, 1)
    call search(l:startq)
    if searchpair(l:startq, '', l:endq, 'n') < 1
        echo "not found pair"
    endif
    call StartNewLineWithRemoveSP()

    while 1
        let [l:plnum, l:pcol] = searchpairpos(l:startq, '', l:endq, 'n')
        let [l:dlnum, l:dcol] = searchpos(l:delim, 'n')
        if l:dlnum == 0 || l:dcol == 0 || l:dlnum > l:plnum || l:dcol > l:pcol
            break
        endif
        call cursor(l:dlnum, l:dcol)
        call StartNewLineWithRemoveSP()
    endwhile
endfunction
noremap <leader>a :call AlignArgs()<cr>

"In C/C++
"Template Generator
"-Support
":Template CPP
":Template C
":Template H
function! InsertText(insert_text) abort
    execute ":normal i" . a:insert_text
endfunction

function! InsertTemplate(type) abort
    let l:lower_type = tolower(a:type)

    if l:lower_type == "cpp"
        call InsertText("#include <iostream>\n\nint main()\n{\n\n}")
    elseif l:lower_type == "c"
        call InsertText("#include <stdio.h>\n\nint main()\n{\n\n}")
    elseif l:lower_type == "h" || l:lower_type == "hpp"
        let l:filename = substitute(toupper(expand("%:t")), "\\.", "_", "g")
        call InsertText("#ifndef _" . l:filename . "\n#define _" . l:filename . "\n\n#endif")
    else
        echo "not supported"
    endif
endfunction

command! -nargs=1 Template :call InsertTemplate(<f-args>)<cr>

"win-vind (https://pit-ray.github.io/win-vind/)
command! GUINormal :AsyncRun win-vind -f change_to_normal
