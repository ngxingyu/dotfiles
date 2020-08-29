" File              : init.vim
" Date              : 28.08.2020
" Last Modified Date: 28.08.2020
if &compatible
  set nocompatible               " Be iMproved
endif

let g:vim_bootstrap_langs = "c,go,html,javascript,python,typescript"
let g:vim_bootstrap_editor = "nvim"


let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')
if !filereadable(vimplug_exists)
  if !executable("curl")
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!\curl -fLo " . vimplug_exists . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"
  autocmd VimEnter * PlugInstall
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

lua << END
    require'nvim_lsp'.tsserver.setup{}
    require'nvim_lsp'.pyls_ms.setup{}
    require'nvim_lsp'.leanls.setup{}
    require'nvim_lsp'.kotlin_language_server.setup{
    settings={kotlin={languageServer={path="/home/ngxingyu/kotlin-language-server/server/build/install/server/bin/"}}}}
    require'nvim_lsp'.bashls.setup{}
    require'nvim_lsp'.clangd.setup{}
    require'nvim_lsp'.texlab.setup{}
    require'nvim_lsp'.jsonls.setup{}
    require'nvim_lsp'.gopls.setup{}
END

let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
augroup ncm2
  au!
  autocmd BufEnter * call ncm2#enable_for_buffer()
  set completeopt=noinsert,menuone,noselect
  au User Ncm2PopupOpen set completeopt=noinsert,menuone,noselect
  au User Ncm2PopupClose set completeopt=menuone
augroup END

let g:float_preview#docked=0

" Optionally
let ncm2#complete_length = [[1, 2]]
let g:ncm2#matcher = 'substrfuzzy'

let g:SuperTabDefaultCompletionType = "<c-n>"

let g:slime_target = "neovim"
let g:slime_paste_file = "$HOME/.slime_paste"
let g:slime_cell_delimiter = "#%%"
let g:slime_python_ipython = 1
let g:python3_host_prog = '~/miniconda3/envs/RL/bin/python3'

let g:rg_command = 'rg --vimgrep -S'
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
let g:vimtex_compiler_progname = 'nvr'
let g:tex_superscripts= "[0-9a-zA-W.,:;+-<>/()=]"
let g:tex_subscripts= "[0-9aehijklmnoprstuvx,+-/().]"

"let g:tex_conceal="abdgm"
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
