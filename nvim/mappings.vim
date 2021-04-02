
let mapleader=" "

nnoremap <silent> <C-h> :call WinMove('h')<cr>
nnoremap <silent> <C-j> :call WinMove('j')<cr>
nnoremap <silent> <C-k> :call WinMove('k')<cr>
nnoremap <silent> <C-l> :call WinMove('l')<cr>

vnoremap <silent><Leader>y "yy <Bar> :call system('xclip', @y)<CR>

nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

function! WinMove(key)
  let t:curwin = winnr()
  exec "wincmd ".a:key
  if (t:curwin == winnr())
    if (match(a:key,'[jk]'))
      wincmd v
    else
      wincmd s
    endif
    exec "wincmd ".a:key
  endif
endfunction

inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf

"Markdown
nnoremap <M-m> :MarkdownPreview<CR>

nmap <F6> :NERDTreeToggle<CR>

nmap <leader>s <Plug>SlimeSendCell
inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <tab>      pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr> <s-tab>    pumvisible() ? "\<c-p>" : "\<tab>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"
" Parameter expansion for selected entry via Enter
inoremap <silent> <expr> <CR> (pumvisible() ? ncm2_ultisnips#expand_or("\<CR>", 'n') : "\<CR>")

nnoremap <silent> <leader>f :FZF<cr>
nnoremap <silent> <leader>F :FZF ~
nnoremap <leader>bn :echo bufnr('%')<Enter>
nnoremap <leader>jn :echo b:terminal_job_id<Enter>

nnoremap <C-s> :w!<cr>
nnoremap <C-q> :q!<cr>
nnoremap <leader>y "+y
nnoremap <leader>p "+p
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>em :vsplit ~/.config/nvim/mappings.vim<cr>
nnoremap <leader>ep :vsplit ~/.config/nvim/plugins.vim<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
tnoremap <Esc> <C-\><C-n>
nnoremap <C-b>c :tabnew +terminal<CR>
tnoremap <C-b>c <C-\><C-n>:tabnew +terminal<CR>
nnoremap <C-b><C-j> :new +terminal<CR>
tnoremap <C-b><C-j> <C-\><C-n>:new +terminal<CR>
nnoremap <C-b><C-l> :vnew +terminal<CR>
tnoremap <C-b><C-l> <C-\><C-n>:vnew +terminal<cr>
nnoremap <C-]> :tabnew %<CR>g<C-]>
vnoremap <C-]> <Esc>:tabnew %<CR>gvg<C-]>
if has('nvim')
    augroup neovim_terminal
        autocmd!

        " Enter Terminal-mode (insert) automatically
        autocmd TermOpen * startinsert

        " Disables number lines on terminal buffers
        autocmd TermOpen * :set nonumber norelativenumber
    augroup END
endif
noremap <Leader>bf :ls<CR>
nnoremap <leader>bq :bp <bar> bd! #<cr>
nnoremap <Leader><Left> :bp<CR>
nnoremap <Leader><Right> :bn<CR>
nnoremap <Leader>1 :1b<CR>
nnoremap <Leader>2 :2b<CR>
nnoremap <Leader>3 :3b<CR>
nnoremap <Leader>4 :4b<CR>
nnoremap <Leader>5 :5b<CR>
nnoremap <Leader>6 :6b<CR>
nnoremap <Leader>7 :7b<CR>
nnoremap <Leader>8 :8b<CR>
nnoremap <Leader>9 :9b<CR>
nnoremap <Leader>0 :10b<CR>

nnoremap th  :tabprev<CR>
nnoremap tj  :tabfirst<CR>
nnoremap tk  :tablast<CR>
nnoremap tl  :tabnext<CR>
nnoremap tt  :tabedit<Space>
nnoremap tn  :tabnew<CR>
nnoremap tm  :tabm<Space>
nnoremap td  :tabclose<CR>

nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

autocmd FileType c nnoremap <buffer> <F5> :w<CR>:!gcc -o %< % && ./%< <CR>
autocmd FileType cpp nnoremap <buffer> <F5> :w<CR>:!g++ -o %< % && ./%< <CR>
autocmd FileType python map <buffer> <F5> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F5> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>

autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

augroup go_files
autocmd!
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
autocmd FileType go nmap <leader>c <Plug>(go-coverage-toggle)
autocmd FileType go nmap <leader>r <Plug>(go-run)
autocmd FileType go nmap <leader>t <Plug>(go-test)
autocmd Filetype go command! -bang Av call go#alternate#Switch(<bang>0, 'vsplit')
augroup end
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space>
  \ denite#do_map('toggle_select').'j'
endfunction

autocmd Filetype lean,tex,html,js,ts,css,python,go,c,cpp setl omnifunc=v:lua.vim.lsp.omnifunc
nnoremap <silent> ;dc <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> ;df <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> ;h  <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> ;i  <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> ;s  <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> ;td <cmd>lua vim.lsp.buf.type_definition()<CR>

xmap ea <Plug>(EasyAlign)
nmap ea <Plug>(EasyAlign)
