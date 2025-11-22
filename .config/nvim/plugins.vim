" File              : plugins.vim
" Date              : 28.08.2020
" Last Modified Date: 28.08.2020
call plug#begin(expand('~/.config/nvim/plugged'))

Plug 'psliwka/vim-smoothie' "Smooth Scroll
"Plug 'editorconfig/editorconfig-vim'
Plug 'chaoren/vim-wordmotion'

Plug 'ryanoasis/vim-devicons' "filetype icons
Plug 'itchyny/lightline.vim' "lightline
Plug 'mengelbrecht/lightline-bufferline' "bufferno
Plug 'edkolev/tmuxline.vim'
"Plug 'christoomey/vim-tmux-navigator' "Use Custom Keybinding.
Plug 'Yggdroot/indentLine'
Plug 'mhinz/vim-startify'
Plug 'TaDaa/vimade' "fade inactive buffers
Plug 'mbbill/undotree' "undo history
Plug 'mcchrish/nnn.vim'

"Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/vim-easy-align'

" TODO review lexima.vim for future change
Plug 'jiangmiao/auto-pairs'
Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh \| UpdateRemotePlugins' } "Debugger

Plug 'liuchengxu/vista.vim' "View LSP tags and symbols
if has ("nvim")
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
"Plug 'akinsho/flutter-tools.nvim'
endif
" Plug 'ncm2/ncm2'
" Plug 'roxma/nvim-yarp'
" Plug 'ncm2/ncm2-bufword'
" Plug 'ncm2/ncm2-path'
" Plug 'ncm2/ncm2-github'
" Plug 'ncm2/ncm2-ultisnips'
" Plug 'ncm2/float-preview.nvim'
" Plug 'ncm2/ncm2-match-highlight'
" Plug 'oncomouse/ncm2-biblatex'
" Plug 'ncm2/ncm2-tern',  {'do': 'npm install'}
" Plug 'ncm2/ncm2-jedi', {'for': 'python' }
" Plug 'ncm2/ncm2-pyclang', {'for': ['c', 'cpp']}
" Plug 'ncm2/ncm2-go'
" Plug 'sebdah/vim-delve' "go debug
Plug 'nsf/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }

" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'Shougo/deoplete-lsp'

" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" Plug 'chemzqm/vim-jsx-improve'
" Plug 'mattn/emmet-vim'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

Plug 'tpope/vim-fugitive'
" Plug 'bfredl/nvim-ipy', {'for': 'python'}

"Plug 'rust-lang/rust.vim'
" Plug 'lervag/vimtex'
" Plug 'alpertuna/vim-header'
Plug 'junegunn/goyo.vim'
" Plug 'pgdouyon/vim-evanesco'
" Plug 'justinmk/vim-dirvish'
Plug 'tpope/vim-eunuch'
Plug 'justinmk/vim-sneak' "search with s
"Plug 'tpope/vim-unimpaired'
Plug 'tomtom/tcomment_vim' "replace nerdcommenter
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround' "change surrounding char
Plug 'alvan/vim-closetag'

Plug 'wellle/targets.vim'
" Plug 'vim-pandoc/vim-pandoc'
" Plug 'vim-pandoc/vim-pandoc-syntax'

" Plug 'leanprover/lean.vim', {'for': 'lean'}
Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'} "
Plug 'dense-analysis/ale'
Plug 'airblade/vim-gitgutter'


Plug 'jpalardy/vim-slime'
" Plug 'cjrh/vim-conda', {'for':'python'}

Plug 'skywind3000/asyncrun.vim'
Plug 'ilyachur/cmake4vim'
Plug 'mfulz/cscope.nvim'

" Plug 'pangloss/vim-javascript'
" Plug 'leafgarland/typescript-vim'
" Plug 'peitalin/vim-jsx-typescript'
" Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
" Plug 'jparise/vim-graphql'
" Plug 'leafOfTree/vim-svelte-plugin'

" Plug 'dart-lang/dart-vim-plugin'
" Plug 'natebosch/vim-lsc'
" Plug 'natebosch/vim-lsc-dart'

Plug 'preservim/nerdtree'

Plug 'vim-test/vim-test'

Plug 'plasticboy/vim-markdown'
Plug 'vim-pandoc/vim-pandoc-syntax'

call plug#end()