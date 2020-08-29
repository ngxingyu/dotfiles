" File              : base.vim
" Date              : 28.08.2020
" Last Modified Date: 28.08.2020
scriptencoding utf-8
syntax enable
set nonu rnu
set showtabline=2
set cursorline
set splitbelow splitright
set mouse=nvirh
set mousemodel=popup_setpos
set clipboard=unnamedplus
set confirm
set autoread
au CursorHold * checktime
set hidden
set title
set winheight=10
set winwidth=80
set winminheight=1
set winminwidth=5

set nobackup writebackup
set incsearch ignorecase smartcase hlsearch
set ruler laststatus=2 showcmd showmode
set inccommand = "split"
set termguicolors
set list listchars=trail:»,tab:»-
set fillchars+=vert:\     
set wrap breakindent
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab autoindent
set signcolumn=yes shortmess+=c 

set foldmethod=indent "syntax
set foldlevelstart=99

colorscheme molokai
highlight Pmenu guibg=white guifg=black gui=bold
highlight Comment gui=bold
highlight Normal gui=none
highlight NonText guibg=none
highlight Normal guibg=NONE ctermbg=NONE
highlight LineNr guibg=NONE ctermbg=NONE

let g:vimade = {}
let g:vimade.fadelevel = 0.7

