" https://github.com/tpope/vim-pathogen
execute pathogen#infect()

" Turn on line numbers
set nu

" Turn on syntax highlighting
syntax on

" Enable plugins and indentation
filetype plugin on

" Expand tabs to spaces with 2 spaces
set ts=2 sw=2 sts=2 et

" https://github.com/hashivim/vim-terraform
" let g:terraform_fmt_on_save=1
let g:terraform_align=1
let g:terraform_fold_sections=1
let g:terraform_remap_spacebar=1

" Source our normal shell
set shell=bash\ --login

" Show them ugly tabs
set list
set listchars=tab:-·,trail:·
