" Author: Vlad Doster <mvdoster@gmail.com>
" Date: 2020-06-26 09:34:08
" Last Modified by: Vlad Doster <mvdoster@gmail.com>
" Last Modified time: 2020-07-01 18:13:22

" leader key
  let mapleader=" "
  nnoremap <Space> <Nop>
  nnoremap c "_c
" Align GitHub-flavored Markdown tables
  au FileType markdown vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>" compile document (groff/LaTeX/markdown/etc)
  map <leader>c :w! \| !compiler <c-r>%<CR>
" spell-check 'o' is for 'orthography'
  map <leader>o :setlocal spell! spelllang=en_us<CR>
" Replace ex mode with gq
  map Q gq" indenting
" indenting
  vnoremap < <gv
  vnoremap > >gv
" omnicomplete
  inoremap <expr> <c-j> ("\<C-n>")
  inoremap <expr> <c-k> ("\<C-p>")
" buffer navigation
  nnoremap <silent> <TAB> :bnext<CR>
  nnoremap <silent> <S-TAB> :bprevious<CR>
" <TAB> completion
  inoremap <silent> <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" resize windows
  nnoremap <silent> <S-h>    :vertical resize -2<CR>
  nnoremap <silent> <S-j>    :resize -2<CR>
  nnoremap <silent> <S-k>    :resize +2<CR>
  nnoremap <silent> <S-l>    :vertical resize +2<CR>
" window navigation
  imap <C-h> <C-w>h
  imap <C-j> <C-w>j
  imap <C-k> <C-w>k
  imap <C-l> <C-w>l
  nnoremap <C-h> <C-w>h
  nnoremap <C-j> <C-w>j
  nnoremap <C-k> <C-w>k
  nnoremap <C-l> <C-w>l
" terminal navigation
  inoremap <C-h> <C-\><C-N><C-w>h
  inoremap <C-j> <C-\><C-N><C-w>j
  inoremap <C-k> <C-\><C-N><C-w>k
  inoremap <C-l> <C-\><C-N><C-w>l
  tnoremap <C-h> <C-\><C-N><C-w>h
  tnoremap <C-j> <C-\><C-N><C-w>j
  tnoremap <C-k> <C-\><C-N><C-w>k
  tnoremap <C-l> <C-\><C-N><C-w>l
  tnoremap <Esc> <C-\><C-n>
