
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
