" Turn on line numbers
set nu

" Turn on syntax highlighting
syntax on

" Enable plugins and indentation
filetype plugin indent on

" https://github.com/tpope/vim-pathogen
execute pathogen#infect()

" https://github.com/hashivim/vim-terraform
let g:terraform_fmt_on_save=1
let g:terraform_align=1
