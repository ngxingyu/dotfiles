" File              : plugins.vim
" Date              : 28.08.2020
" Last Modified Date: 28.08.2020
call plug#begin(expand('~/.config/nvim/plugged'))

" Core editing
Plug 'psliwka/vim-smoothie' " Smooth scroll
Plug 'chaoren/vim-wordmotion'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround' " Change surrounding char
Plug 'tpope/vim-repeat'
Plug 'wellle/targets.vim'

" UI and navigation
Plug 'ryanoasis/vim-devicons' " Filetype icons
Plug 'itchyny/lightline.vim' " Statusline
Plug 'mengelbrecht/lightline-bufferline' " Buffer line
Plug 'edkolev/tmuxline.vim'
Plug 'Yggdroot/indentLine'
Plug 'mhinz/vim-startify'
Plug 'TaDaa/vimade' " Fade inactive buffers
Plug 'mbbill/undotree' " Undo history
Plug 'mcchrish/nnn.vim' " File browser
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/vim-easy-align'

" LSP and completion
if has("nvim")
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
endif

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Tmux integration
Plug 'jpalardy/vim-slime'

" Build and debug
Plug 'skywind3000/asyncrun.vim'
Plug 'ilyachur/cmake4vim'
Plug 'mfulz/cscope.nvim'
Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh \| UpdateRemotePlugins' } " Debugger

" Tags and symbols
Plug 'liuchengxu/vista.vim' " View LSP tags and symbols

" Testing
Plug 'vim-test/vim-test'

" Markdown
Plug 'plasticboy/vim-markdown'

call plug#end()

if has('nvim')
lua << EOF
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable,
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  })
})

-- LSP setup with cmp capabilities
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Setup LSP servers for robotics dev (Python, C++)
vim.lsp.config('pyright', { capabilities = capabilities })
vim.lsp.enable('pyright')
vim.lsp.config('clangd', { capabilities = capabilities })
vim.lsp.enable('clangd')
-- Add more if needed, e.g., for ROS2 specific
EOF
endif