" => Encoding settings -----------------------------------------------{{{1
set encoding=utf-8
set fileformats=unix,dos,mac
set nocompatible
set fileencodings=utf-8,cp932,euc-jp,iso-20220-jp,default,latin
scriptencoding

if !has('nvim')
  set pythonthreedll=C:/Python37/python37.dll
endif

" => Common bindings --------------------------------------------------{{{1
let mapleader = "\<space>"

" => Install plugins --------------------------------------------------{{{1
let $VIMHOME = $HOME . (has('win32') ? '/vimfiles' : '/.vim')
if empty(glob($VIMHOME . '/autoload/plug.vim'))
  exe('term curl -fLo ' . $VIMHOME . '/autoload/plug.vim --create-dirs https://raw.github.com/junegunn/vim-plug/master/plug.vim')
  exe('source ' . $VIMHOME . '/autoload/plug.vim')
  au! VimEnter * PlugInstall --sync | so $MYVIMRC
endif

call plug#begin($VIMHOME . '/plugged')

" Stable
Plug 'agatan/vim-sort-include'
Plug 'cespare/vim-toml', {'for': 'toml'}
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mattn/vim-gist'
Plug 'mattn/webapi-vim'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/vim-easy-align'
Plug 'mattn/emmet-vim', {'for': 'html'}
Plug 'mattn/vim-lsp-settings'
Plug 'mhinz/vim-startify'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'simeji/winresizer'
Plug 'skywind3000/asyncrun.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
Plug 'vhdirk/vim-cmake', {'for': ['c', 'cpp']}
Plug 'vim-airline/vim-airline'
Plug 'vim-scripts/nsis.vim', {'for': ['nsi', 'in']}
Plug 'mattn/vim-notification'

" Colorschemes
Plug 'sainnhe/gruvbox-material'
Plug 'ghifarit53/tokyonight-vim'
Plug 'junegunn/seoul256.vim'
Plug 'sonph/onehalf', {'rtp': 'vim'}
Plug 'arcticicestudio/nord-vim'
call plug#end()

command! So so<space>$MYVIMRC
command! Update PlugInstall | VimspectorInstall

au! BufNewFile,BufRead *.vindrc set filetype=vim

" => Plugin Options -------------------------------------------------{{{1
" vim-sort-include
au! BufWritePre *.{c,cpp,h,hpp,cc} SortInclude

"vim-lsp
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_log_verbose = 0
let g:lsp_diagnostics_float_cursor = 0
let g:lsp_diagnostics_float_delay = 500

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

"vim-easymotion
nmap f <Plug>(easymotion-f)
nmap F <Plug>(easymotion-overwin-f)
nmap t <Plug>(easymotion-w)
nmap T <Plug>(easymotion-b)
nmap s <Plug>(easymotion-s2)

function! EnableVimspector() abort
  let l:py3_dll = system('cmd /c where.exe python3.dll')
  let l:py3_dll = substitute(l:py3_dll, '/', '\', 'g')

  echo 'Detected Python module: ' . l:py3_dll

  let l:base = join(split(l:py3_dll, '\')[0:-2], '\')
  let l:py3 = l:base . '\python'
  let l:choice = confirm('Can install the neovim library into ' . l:py3 . '?', "&Yes\n&No")
  if l:choice == 1
    call system(l:py3 . ' -m pip install neovim')
  endif

  call execute('set pythonthreedll=' . l:py3_dll)

  call plug#begin()
  Plug 'puremourning/vimspector'
  call plug#end()

  " vimspector
  let g:vimspector_enable_mappings = 'VISUAL_STUDIO'
  let g:vimspector_install_gadgets = ['debugpy', 'vscode-cpptools', 'CodeLLDB']
endfunction

command! EnableVimspector :call EnableVimspector()

" => Color Scheme --------------------------------------------------{{{1
syntax enable
set background=dark
if has('termguicolors')
  set termguicolors
endif

" ==> Each settings
let g:gruvbox_material_background = 'soft'
let g:airline_theem = 'gruvbox_material'

if has('syntax')
  au! Colorscheme * highlight FullWidthSpace term=underline ctermbg=DarkGreen guibg=DarkGreen
  au! VimEnter,WinEnter * match FullWidthSpace /　/
endif

colorscheme nord

" => Native Common Settings ----------------------------------------------{{{1
set hlsearch                        "show highlight
set showmatch                       "show matched brackets
set ruler                           "show cursor position
set number                          "show line number set showcmd                         "show inputting commands
set list                            "show invisible char
set listchars=tab:>-,trail:.        "tab - space .
if has('gui_running') && has('vim_starting')
  set lines=32                        "initial window height
  set columns=128                     "initial window width
endif

set pumheight=10                    "height of popup menu

"indent
filetype plugin indent on           "detect filetype
set autoindent                      "automatic indent
set expandtab                       "convert tab to space

au! FileType txt,c,cpp,scss,css,html,md,cmake setlocal ts=4 sts=4 sw=4
au! FileType json,vim,yml,tex setlocal ts=2 sts=2 sw=2
set foldmethod=marker               "fold with maker (e.g. {{{1)
set foldlevel=100                   "initial fold mode

"other
set nowrapscan                      "There is End of search
set nowrap                          "not wrap a long line

set nobackup                        "not make backup files
set noswapfile                      "not make swap files
set backspace=indent,eol,start      "behavior of back space
set wildmenu                        "more informational completion
set wildmode=list:longest,full      "wildmenu's behavior

set novb t_vb=                      "disable all beep
set noerrorbells                    "disable error beep

if has('win32')
  set shell=powershell
  set clipboard=unnamed,autoselect    "copy to OS's clipboard
endif

set undodir=$VIMHOME                "infinity undo

" => Native GUI settings -------------------------------------------------{{{1
set guioptions-=m                   "disable gui menubar
set guioptions-=T                   "disable gui toolbar
set guifont=Consolas:h8

" => My bindings ---------------------------------------------------------{{{1
noremap <c-h> <c-w><c-h>
noremap <c-j> <c-w><c-j>
noremap <c-k> <c-w><c-k>
noremap <c-l> <c-w><c-l>

noremap <c-left> <c-w><c-h>
noremap <c-down> <c-w><c-j>
noremap <c-up> <c-w><c-k>
noremap <c-right> <c-w><c-l>

noremap <m-l> :cn<cr>
noremap <m-h> :cp<cr>

if has('terminal')
  tnoremap <c-h> <c-w><c-h>
  tnoremap <c-j> <c-w><c-j>
  tnoremap <c-k> <c-w><c-k>
  tnoremap <c-l> <c-w><c-l>

  tnoremap <c-left> <c-w><c-h>
  tnoremap <c-down> <c-w><c-j>
  tnoremap <c-up> <c-w><c-k>
  tnoremap <c-right> <c-w><c-l>

  tnoremap <c-i> <c-w><s-n>
endif

"let g:termdebug_use_prompt = 0
" noremap <leader>b :Break<cr>
" noremap <f5> :Continue<cr>
" noremap <leader>e :Evaluate<cr>
" noremap <leader>g :Gdb<cr>
" noremap <leader>s :Step<cr>
" noremap <leader>o :Over<cr>
" noremap <leader>q :Gdb<cr><esc>iquit<cr>
" noremap <leader>r :Run<cr><esc>:Source<cr>

" => My functions  ---------------------------------------------------------{{{1
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


"Utilities
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

function! InsertTemplate() abort
  let l:t = tolower(expand("%:e"))

  if l:t == "cpp" || l:t == "cxx" || l:t == "cc"
    call InsertText("#include <iostream>\n\nint main()\n{\n\n}")
  elseif l:t == "c"
    call InsertText("#include <stdio.h>\n\nint main()\n{\n\n}")
  elseif l:t == "h" || l:t == "hpp"
    let l:filename = substitute(toupper(expand("%:t")), "\\.", "_", "g")
    call InsertText("#ifndef _" . l:filename . "\n#define _" . l:filename . "\n\n#endif")
  elseif l:t == "py"
    call InsertText("# coding: utf-8\n")
    call InsertText("\n")
    call InsertText("if __name__ == '__main__':\n")
    call InsertText("    print()\n")
  else
    echo "not supported"
  endif
endfunction

command! Template :call InsertTemplate()


" Quick Project Creater
function! CreateFile(name) abort
  let l:path = expand("%:p:h") . "/" . a:name
  silent execute "e " . l:path
  silent execute("write")
  return l:path
endfunction

function! CreateCmakeProject(...) abort
  split

  let l:flags_path = CreateFile("compile_flags.txt")
  if getfsize(l:flags_path) == 0
    call InsertText("-I.")
    silent execute("write")
  endif

  let l:name = "a"
  if a:0 > 0
    let l:name = a:1
  endif

  let l:cmake_lists_path = CreateFile("CMakeLists.txt")
  if getfsize(l:cmake_lists_path) == 0
    call InsertText("cmake_minimum_required(VERSION 3.0.0)\n")
    call InsertText("project(" . l:name . " VERSION 1.0.0)\n")
    call InsertText("include_directories(${PROJECT_SOURCE_DIR})\n")
    call InsertText("add_executable(${PROJECT_NAME})")
    silent execute("write")
  endif
endfunction

command! -nargs=* QuickCmake :call CreateCmakeProject(<f-args>)

"win-vind (https://pit-ray.github.io/win-vind/)
command! GUINormal :AsyncRun win-vind -f change_to_normal

function! Dos2Unix() abort
  write
  edit! ++ff=unix
  execute "%s///ge"
  execute "%s/\r//ge"
endfunction
"au! BufWritePre,FileType *.{vim,vimc} call Dos2Unix()

command! Dos2Unix :call Dos2Unix()


" .vimspector.json
function! CreateVimSpectorConfig(type) abort
  let l:cmake_lists_path = CreateFile(".vimspector.json")
  if getfsize(l:cmake_lists_path) != 0
    return
  endif

  let l:lower_type = tolower(a:type)

  if l:lower_type == "c"
    call InsertText("{\n")
    call InsertText("  \"configurations\": {\n")
    call InsertText("    \"cpp\": {\n")
    call InsertText("      \"adapter\": \"vscode-cpptools\",\n")
    call InsertText("      \"configuration\": {\n")
    call InsertText("        \"type\": \"cppdbg\",\n")
    call InsertText("        \"request\": \"launch\",\n")
    call InsertText("        \"program\": \"${workspaceRoot}/a.exe\",\n")
    call InsertText("        \"args\": [],\n")
    call InsertText("        \"cwd\": \"${workspaceRoot}\",\n")
    call InsertText("        \"environment\": [],\n")
    call InsertText("        \"externalConsole\": false,\n")
    call InsertText("        \"stopAtEntry\": true,\n")
    call InsertText("        \"MIMode\": \"gdb\",\n")
    call InsertText("        \"logging\": {\n")
    call InsertText("          \"engineLogging\": false\n")
    call InsertText("        }\n")
    call InsertText("      }\n")
    call InsertText("    }\n")
    call InsertText("  }\n")
    call InsertText("}")
  endif
  silent execute("write")
endfunction

command! -nargs=1 VimspectorCreate :call CreateVimSpectorConfig(<f-args>)
