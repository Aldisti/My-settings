
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
autocmd FileType sh,shell setlocal expandtab ts=4 sw=4 sts=4
autocmd FileType xml setlocal expandtab ts=4 sw=4 sts=4
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
let g:indentLine_char='¦'
" let g:indentLine_char_list=['¦','.']
let g:indentLine_enabled=1
" let g:indentLine_setTabs=1
" let g:indentLine_setConceal=0
let g:indentLine_showFirstIndentLevel=0

" ---------------------------------------------------------

" ## added by OPAM user-setup for vim / base ## d611dd144a5764d46fdea4c0c2e0ba07 ## you can edit, but keep this line
let s:opam_share_dir = system("opam var share")
let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

let s:opam_configuration = {}

function! OpamConfOcpIndent()
  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
endfunction
let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

function! OpamConfOcpIndex()
  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
endfunction
let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

function! OpamConfMerlin()
  let l:dir = s:opam_share_dir . "/merlin/vim"
  execute "set rtp+=" . l:dir
endfunction
let s:opam_configuration['merlin'] = function('OpamConfMerlin')

let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
let s:opam_available_tools = []
for tool in s:opam_packages
  " Respect package order (merlin should be after ocp-index)
  if isdirectory(s:opam_share_dir . "/" . tool)
    call add(s:opam_available_tools, tool)
    call s:opam_configuration[tool]()
  endif
endfor
" ## end of OPAM user-setup addition for vim / base ## keep this line
" ## added by OPAM user-setup for vim / ocp-indent ## 5224dce0304203ce3e40c4240ad19178 ## you can edit, but keep this line
if count(s:opam_available_tools,"ocp-indent") == 0
  source "/home/aldisti/.opam/lsp-5.3/share/ocp-indent/vim/indent/ocaml.vim"
endif
" ## end of OPAM user-setup addition for vim / ocp-indent ## keep this line
