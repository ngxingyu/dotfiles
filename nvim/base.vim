scriptencoding utf-8
syntax enable
set nonu rnu
set showtabline=2
set cursorline
set splitbelow splitright
set mouse=nvirh
set mousemodel=popup_setpos
set clipboard=unnamed
set confirm
set autoread
au CursorHold * checktime
set hidden
set title
" set winheight=10
" set winwidth=80
" set winminheight=10
" set winminwidth=8
let NERDTreeWinSize=20
let NERDTreeMapOpenInTab='<ENTER>'

let g:indentLine_fileTypeExclude = ['tex']

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

function! UseTabs()
  set tabstop=4     " Size of a hard tabstop (ts).
  set shiftwidth=4  " Size of an indentation (sw).
  set noexpandtab   " Always uses tabs instead of space characters (noet).
  set autoindent    " Copy indent from current line when starting a new line (ai).
endfunction

function! UseSpaces()
  set tabstop=2     " Size of a hard tabstop (ts).
  set shiftwidth=2  " Size of an indentation (sw).
  set expandtab     " Always uses spaces instead of tab characters (et).
  set softtabstop=0 " Number of spaces a <Tab> counts for. When 0, featuer is off (sts).
  set autoindent    " Copy indent from current line when starting a new line.
  set smarttab      " Inserts blanks on a <Tab> key (as per sw, ts and sts).
endfunction

au! BufWrite,FileWritePre *.module,*.install,*.py call UseSpaces()
au! BufWrite,FileWritePre *.svelte,*.html,*.js,*.ts call UseTabs()
