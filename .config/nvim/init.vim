syntax on
"# ---------------------------- #
"#           Plugins            #
"# ---------------------------- #
if ! filereadable(system('echo -n  ~/.config/nvim/autoload/plug.vim'))
	silent !mkdir -p ~/.config/nvim/autoload
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif
call plug#begin(system('echo -n ~/.config/nvim/plugged'))
Plug 'Vigemus/nvimux'       " terminal multiplexer
Plug 'mbbill/undotree'      " undo history visualizer
Plug 'preservim/nerdtree'   " file system explorer
Plug 'sheerun/vim-polyglot' " language pack
Plug 'tpope/vim-commentary' " comment stuff
Plug 'tpope/vim-fugitive'   " git wrapper
Plug 'tpope/vim-surround'   " quoting/parenthesizing made simple
Plug 'vim-utils/vim-man'    " view and grep for man pages
Plug 'vimwiki/vimwiki'      " personal wiki
Plug 'junegunn/fzf.vim'     " fuzzy finder
Plug 'ap/vim-css-color'     " color value viewer
Plug 'morhetz/gruvbox'      " retro groove color scheme
Plug 'vim-airline/vim-airline' " status/tabline
Plug 'z0mbix/vim-shfmt', { 'for': 'sh' } " sh script formatter
Plug 'neoclide/coc.nvim', {'branch': 'release'} " intellisense
call plug#end()
"# ---------------------------- #
"#           General            #
"# ---------------------------- #
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
set hidden
set incsearch
set modifiable
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
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P}
set tabstop=4 softtabstop=4
set termguicolors
set undodir=$XDG_DATA_HOME/nvim/undo
set undofile
set updatetime=50

autocmd BufWritePost ~/.local/src/dwm-blocks/config.h
                   \ !cd ~/.local/src/dwm-blocks/ &&
                   \ sudo make install &&
                   \ { killall -q dwmblocks;setsid dwmblocks & }
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
set wildmode=longest,list,full

au BufNewFile *.py call ScriptHeader()
au BufNewFile *.sh call ScriptHeader()
function ScriptHeader()
    if &filetype == 'python'
        let header = "#!/usr/bin/env python"
        let cfg = "# vim: ts=4 sw=4 sts=4 expandtab"
    elseif &filetype == 'sh'
        let header = "#!/bin/bash"
    endif
    let line = getline(1)
    if line == header
        return
    endif
    normal m'
    call append(0,header)
    if &filetype == 'python'
        call append(2, cfg)
    endif
    normal ''
endfunction

cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
map <leader>c :w! \| !compiler <c-r>%<CR>
" Neovim :Terminal
tmap <Esc> <C-\><C-n>
tmap <C-w> <Esc><C-w>
autocmd BufWinEnter,WinEnter term://* startinsert
autocmd BufLeave term://* stopinsert

tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
tnoremap <Esc> <C-\><C-n>

inoremap <A-h> <C-\><C-N><C-w>
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l

nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
" Spell check set to <leader>o, 'o' for 'orthography'
map <leader>o :setlocal spell! spelllang=en_us<CR>
" Splits open at the bottom and right, which is non-autistic, unlike vim defaults
set splitbelow splitright
" Remove whitespace on save
fun! TrimWhitespace()
	let l:save = winsaveview()
	keeppatterns %s/\s\+$//e
	call winrestview(l:save)
endfun
autocmd BufWritePre * :call TrimWhitespace()
" Replace all is aliased to S
nnoremap S :%s//g<Left><Left>
" When shortcut files are updated, renew bash and ranger configs
autocmd BufWritePost files,directories !generate_shortcuts
"# ---------------------------- #
"#             CoC              #
"# ---------------------------- #
" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
if &diff
    highlight! link DiffText MatchParen
endif

inoremap <silent><expr> <TAB>
	\ pumvisible() ? "\<C-n>" :
	\ <SID>check_back_space() ? "\<TAB>" :
	\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Map function and class text objects
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

command! -nargs=0 Format :call CocAction('format')
command! -nargs=? Fold :call CocAction('fold', <f-args>)
command! -nargs=0 OR   :call CocAction('runCommand', 'editor.action.organizeImport')
"-- JSON -- "
autocmd FileType json syntax match Comment +\/\/.\+$+
"# ---------------------------- #
"#            shfmt             #
"# ---------------------------- #
" indent, indent switch cases, add space after redirect operators, simplify code
let g:shfmt_extra_args = '-i 2 -ci -sr -s'
let g:shfmt_fmt_on_save = 1
"# ---------------------------- #
"#     Color scheme related     #
"# ---------------------------- #
highlight ColorColumn ctermbg=0 guibg=lightgrey
colorscheme gruvbox
set background=dark
"# ---------------------------- #
"#          FuGITive            #
"# ---------------------------- #
nmap <leader>gh :diffget //3<CR>
nmap <leader>gu :diffget //2<CR>
nmap <leader>gs :G<CR>
"# ---------------------------- #
"#     GoTo code navigation     #
"# ---------------------------- #
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
"# ---------------------------- #
"#            Netrw             #
"# ---------------------------- #
let g:netrw_browse_split = 2
let g:vrfr_rg = 'true'
let g:netrw_banner = 0
let g:netrw_winsize = 25
"# ---------------------------- #
"#          NerdTree            #
"# ---------------------------- #
"#- Key to open
map <leader>n :NERDTreeToggle<CR>
"#- Misc. settings
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeShowHidden=1
let NERDTreeBookmarksFile = stdpath('data') . '/NERDTreeBookmarks'
"# ---------------------------- #
"#          Vim Wiki            #
"# ---------------------------- #
map <leader>v :VimwikiIndex
let g:vimwiki_list = [{'path':'~/.local/src/vimwiki.git/',
                     \ 'syntax': 'default',
                     \ 'ext': '.md'}]
let wiki = {}
let wiki.path = '~/.local}/src/vimwiki.git/'
let wiki.nested_syntaxes = { 'bash': 'bash', 'python': 'python' }
let g:vimwiki_list = [wiki]
"# ---------------------------- #
"#            Nvimux            #
"# ---------------------------- #
lua << EOF
local nvimux = require('nvimux')

nvimux.config.set_all{
  prefix = '<C-a>',
  new_window = 'term',
  new_tab = term,
  new_window_buffer = 'single',
  quickterm_direction = 'botright',
  quickterm_orientation = 'vertical',
  quickterm_scope = 't',
  quickterm_size = '80',
}

nvimux.bindings.bind_all{
  {'s', ':NvimuxHorizontalSplit', {'n', 'v', 'i', 't'}},
  {'v', ':NvimuxVerticalSplit', {'n', 'v', 'i', 't'}},
}

nvimux.bootstrap()
EOF
