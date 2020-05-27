" # --- Load/Install plugins --- #
if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
Plug 'ap/vim-css-color'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/goyo.vim'
Plug 'mbbill/undotree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'vim-utils/vim-man'
Plug 'vimwiki/vimwiki'
Plug 'z0mbix/vim-shfmt', { 'for': 'sh' }
" Color schemes plugins
Plug 'flazz/vim-colorschemes'
Plug 'morhetz/gruvbox'
Plug 'phanviet/vim-monokai-pro'
Plug 'vim-airline/vim-airline'
call plug#end()

" # --- Basics --- #
filetype plugin on
let loaded_matchparen = 1
let mapleader =" "
nnoremap c "_c
set clipboard+=unnamedplus
set cmdheight=2
set colorcolumn=80
set encoding=utf-8
set expandtab
set go=a
set guicursor=
set hidden
set incsearch
set mouse=a
set nobackup
set nocompatible
set noerrorbells
set nohlsearch
set noshowmatch
set noswapfile
set nowrap
set nowritebackup
set nu
set relativenumber
set scrolloff=8
set shiftwidth=4
set shortmess+=c
set smartcase
set smartindent
set tabstop=4 softtabstop=4
set termguicolors
let undodir=system('echo ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/undodir')
set undodir=undodir
set undofile
set updatetime=50
syntax on

" remove whitespace on save
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

autocmd BufWritePre * :call TrimWhitespace()

" Spell-check set to <leader>o, 'o' for 'orthography':
map <leader>o :setlocal spell! spelllang=en_us<CR>

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
set splitbelow splitright

" Enable autocompletion:
set wildmode=longest,list,full

" Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Shortcutting split navigation, saving a keypress:
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Replace ex mode with gq
map Q gq

" Replace all is aliased to S.
nnoremap S :%s//g<Left><Left>

" Compile document, be it groff/LaTeX/markdown/etc.
map <leader>c :w! \| !compiler <c-r>%<CR>

" Compile dwm-blocks when exiting config.h
 autocmd BufWritePost ~/.local/src/dwm-blocks/config.h
                      \ !cd ~/.local/src/dwm-blocks/ &&
                      \ sudo make install &&
                      \ { killall -q dwmblocks;setsid dwmblocks & }

" Save file as sudo on files that require root permission
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" When shortcut files are updated, renew bash and ranger configs with new material:
autocmd BufWritePost files,directories !generate_shortcuts

" # --- Color scheme related --- #
highlight ColorColumn ctermbg=0 guibg=lightgrey
colorscheme gruvbox
set background=dark

" # --- Netrw --- #
let g:netrw_browse_split = 2
let g:vrfr_rg = 'true'
let g:netrw_banner = 0
let g:netrw_winsize = 25

" # --- GoTo code navigation --- #
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>rr <Plug>(coc-rename)
nmap <leader>g[ <Plug>(coc-diagnostic-prev)
nmap <leader>g] <Plug>(coc-diagnostic-next)
nmap <silent> <leader>gp <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>gn <Plug>(coc-diagnostic-next)
nnoremap <leader>cr :CocRestart

" # --- FuGITive --- #
nmap <leader>gh :diffget //3<CR>
nmap <leader>gu :diffget //2<CR>
nmap <leader>gs :G<CR>
nmap <leader>ga :Git add -u<CR>
nmap <leader>gc :Git commit<CR>
nmap <leader>g^ :Git push<CR>
nmap <leader>gv :Git pull<CR>

" # --- Nerd tree --- #
map <leader>n :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeShowHidden=1
let NERDTreeBookmarksFile = stdpath('data') . '/NERDTreeBookmarks'

" # --- Vim Wiki --- #
map <leader>v :VimwikiIndex
let g:vimwiki_list = [{'path':system('echo -n "${XDG_USER_LOCAL:-$HOME/.local}/src/vimwiki.git/"'),
                     \ 'syntax': 'default',
		     \ 'ext': '.md'}]
let wiki = {}
let wiki.path = system('echo -n "${XDG_USER_LOCAL:-$HOME/.local}/src/vimwiki.git/"')
let wiki.nested_syntaxes = { 'bash': 'bash',
			   \ 'python': 'python }
let g:vimwiki_list = [wiki]

" # --- Code of Completion --- #
" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')%{FugitiveStatusline()}}
" Autocomplete with control space, similiar to Pycharm
inoremap <silent><expr> <c-space> coc#refresh()
" `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')
" `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
" Turns off highlighting on changed code, so line is highlighted but the actual text that has changed stands out on the line and is readable.
if &diff
    highlight! link DiffText MatchParen
endif
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" # --- Language servers --- #
" # --- Bash --- #
" indent, indent switch cases, add space after redirect operators, simplify code
let g:shfmt_extra_args = '-i 2 -ci -sr -s'
let g:shfmt_fmt_on_save = 1

" Check file in shellcheck:
map <leader>s :!clear && shellcheck %<CR>

" # --- JSON --- #
autocmd FileType json syntax match Comment +\/\/.\+$+

" # --- Python --- #
