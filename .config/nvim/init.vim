
if &compatible
    set nocompatible               " Be iMproved
endif

let g:vim_bootstrap_langs = ""
let g:vim_bootstrap_editor = "nvim"
let g:lsc_auto_map = v:true
set clipboard+=unnamedplus
set redrawtime=5000
function! ClipboardYank()
      call system('xclip -i -selection clipboard', @@)
  endfunction
  function! ClipboardPaste()
        let @@ = system('xclip -o -selection clipboard')
    endfunction

    vnoremap <silent> y y:call ClipboardYank()<cr>
    vnoremap <silent> d d:call ClipboardYank()<cr>
    nnoremap <silent> p :call ClipboardPaste()<cr>p


"markdown

let g:vim_markdown_folding_disabled = 1

" do not use conceal feature, the implementation is not so good
let g:vim_markdown_conceal = 0
let g:vim_markdown_math = 1

" support front matter of various format
let g:vim_markdown_frontmatter = 1  " for YAML format
let g:vim_markdown_toml_frontmatter = 1  " for TOML format
let g:vim_markdown_json_frontmatter = 1  " for JSON format"
augroup pandoc_syntax
    au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
augroup END
let plug_dir = expand('~/.config/nvim/plugged')
if empty(glob(plug_dir . '/*'))
  autocmd VimEnter * ++once PlugInstall --sync | source $MYVIMRC
endif


"-------------------Load files-----------------
source ~/.config/nvim/base.vim
source ~/.config/nvim/plugins.vim
source ~/.config/nvim/mappings.vim

let g:ale_linters = {
            \ 'python': ['pylint'],
            \ 'vim': ['vint'],
            \ 'cpp': ['clang'],
            \ 'c': ['clang']
            \}

let g:float_preview#docked=0

" " Optionally
" let ncm2#complete_length = [[1, 2]]
" let g:ncm2#matcher = 'substrfuzzy'

let g:slime_target = "tmux"

let g:rg_command = 'rg --vimgrep -S'

set conceallevel=2
hi Conceal guibg=Black guifg=White
let g:tex_conceal="abdgms"
au FileType tex syn region texMathZoneZ matchgroup=texStatement start="\\eqn{"  start="\\eqns{" start="\\eqna{" start="\\eqnas{"    matchgroup=texStatement end="}" end="%stopzone\>"   contains=@texMathZoneGroup



let g:nnn#set_default_mappings = 0
nnoremap <silent> <leader>nn :NnnPicker<CR>
nnoremap <leader>n :NnnPicker '%:p:h'<CR>
let g:nnn#layout = 'new'
let g:nnn#layout = { 'left': '~20%' } " or right, up, downu
let g:nnn#layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Debug' } }
let g:nnn#action = {
            \ '<c-t>': 'tab split',
            \ '<c-j>': 'split',
            \ '<c-l>': 'vsplit' }

hi CursorLine guibg=#3d3d3d
set cursorcolumn
hi SignColumn guibg=#282828
" augroup ReduceNoise
"     autocmd!
"     autocmd WinEnter * :call ResizeSplits()
"     autocmd WinEnter * setlocal cursorline
"     autocmd WinEnter * setlocal signcolumn=auto
"     autocmd WinLeave * setlocal nocursorline
"     autocmd WinLeave * setlocal signcolumn=no
" augroup END
"
" function! ResizeSplits()
"     if &ft == 'nerdtree'
"         return
"     elseif &ft == 'qf'
"         resize 10
"         return
"     else
"         set winwidth=100
"         wincmd =
"     endif
" endfunction