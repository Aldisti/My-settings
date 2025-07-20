
" this should be clear
syntax on
" shows the columns number
set number
" unset the previous command
" set nonumber

set ts=4 " tabstop
set sw=4 " shiftwidth
set sts=4 " softtabstop

set ai " autoindent
set si " smartindent

" let's you use the mouse
set mouse=a
" let's you copy with the mouse
" set mouse=c

set showmatch
set title
set scrolloff=10
set showcmd

command! W w
command! Q q
command! Wq wq
command! WQ wq


" saves the undo in a file
set undofile
" sets in which dir save the undofile
set undodir=~/.vim/undo
" set the max level of undos
set undolevels=100
" not really clear
set undoreload=1000



" Adaptive indentation type and size ----------------------

" Use filetype detection
filetype on
filetype indent on

" Python: 4 spaces
autocmd FileType python setlocal expandtab ts=4 sw=4 sts=4
" YAML: 2 spaces
autocmd FileType yaml,yml setlocal expandtab ts=2 sw=2 sts=2
" C / C++: real tabs, tab width = 4
autocmd FileType c,cpp setlocal noexpandtab ts=4 sw=4 sts=4
autocmd FileType go setlocal noexpandtab ts=4 sw=4 sts=4

" ---------------------------------------------------------

filetype plugin indent on

" Plugin manager and indent guide plugin ------------------

" Initialize plugin system
call plug#begin('~/.vim/plugged')
" Indent guide plugin
Plug 'Yggdroot/indentLine'
call plug#end()

" Use a dot for indent lines
" let g:indentLine_char='¦'
let g:indentLine_char_list=['¦','.']
let g:indentLine_enabled=1
" let g:indentLine_setTabs=1
" let g:indentLine_setConceal=0
let g:indentLine_showFirstIndentLevel=0

" ---------------------------------------------------------

