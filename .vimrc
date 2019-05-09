" Turn on line numbers
set nu

" Turn on syntax highlighting
syntax on

" Enable plugins and indentation
filetype plugin on

" https://github.com/tpope/vim-pathogen
execute pathogen#infect()

" https://github.com/leafgarland/typescript-vim

" https://github.com/hashivim/vim-terraform
let g:terraform_fmt_on_save=1
let g:terraform_align=1
