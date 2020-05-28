syntax on
"# ---------------------------- #
"#           Plugins            #
"# ---------------------------- #
" Load ||  Install
	if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
		echo "Downloading junegunn/vim-plug to manage plugins..."
		silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
		silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
		autocmd VimEnter * PlugInstall
	endif
" Plugins source
	call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
	Plug 'junegunn/fzf.vim'
	Plug 'junegunn/goyo.vim'
	Plug 'mbbill/undotree'
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'preservim/nerdtree'
	Plug 'sheerun/vim-polyglot'
	Plug 'tpope/vim-commentary'
	Plug 'tpope/vim-fugitive'
	Plug 'tpope/vim-surround'
	Plug 'vim-utils/vim-man'
	Plug 'vimwiki/vimwiki'
	Plug 'z0mbix/vim-shfmt', { 'for': 'sh' }
    Plug 'tpope/vim-unimpaired'
" Color scheme plugins
	Plug 'ap/vim-css-color'
	Plug 'flazz/vim-colorschemes'
	Plug 'morhetz/gruvbox'
	Plug 'phanviet/vim-monokai-pro'
	Plug 'vim-airline/vim-airline'
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
	set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P}
	set tabstop=4 softtabstop=4
	set termguicolors
	set undodir=$XDG_DATA_HOME/nvim/undo
	set undofile
	set updatetime=50
" Compile document, be it groff/LaTeX/markdown/etc
	map <leader>c :w! \| !compiler <c-r>%<CR>
" Compile dwm-blocks when exiting config.h
	autocmd BufWritePost ~/.local/src/dwm-blocks/config.h
                       \ !cd ~/.local/src/dwm-blocks/ &&
                       \ sudo make install &&
                       \ { killall -q dwmblocks;setsid dwmblocks & }
" Disables automatic commenting on newline
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" Enable autocompletion
	set wildmode=longest,list,full
" New python/sh files get headers
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
" Save file as sudo on files that require root permission
	cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
" Shortcut split navigation saves a keypress
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l
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
" Replace ex mode with gq
	map Q gq
" When shortcut files are updated, renew bash and ranger configs
	autocmd BufWritePost files,directories !generate_shortcuts
"# ---------------------------- #
"#             CoC              #
"# ---------------------------- #
"== GENERAL =="
" `:Format` to format current buffer
	command! -nargs=0 Format :call CocAction('format')
" `:OR` for organize import of current buffer
	command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
" Turns off highlighting on changed code so line is highlighted
" but the actual text that has changed stands out on the line and is readable
	if &diff
    	highlight! link DiffText MatchParen
	endif
" Tab for completion with characters ahead and navigate
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin
	inoremap <silent><expr> <TAB>
		\ pumvisible() ? "\<C-n>" :
		\ <SID>check_back_space() ? "\<TAB>" :
		\ coc#refresh()
	inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

	function! s:check_back_space() abort
  		let col = col('.') - 1
  		return !col || getline('.')[col - 1]  =~# '\s'
	endfunction
"== LANGUAGE SPECIFIC =="
"-> BASH
" Indent, add space after redirect operators, simplify code
	let g:shfmt_extra_args = '-i 2 -ci -sr -s'
	let g:shfmt_fmt_on_save = 1
" Shellcheck
	map <leader>s :!clear && shellcheck %<CR>
"-> JSON
	autocmd FileType json syntax match Comment +\/\/.\+$+
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
	let g:vimwiki_list = [{'path':system('echo -n "${XDG_USER_LOCAL:-$HOME/.local}/src/vimwiki.git/"'),
			     		 \ 'syntax': 'default',
						 \ 'ext': '.md'}]
	let wiki = {}
	let wiki.path = system('echo -n "${XDG_USER_LOCAL:-$HOME/.local}/src/vimwiki.git/"')
	let wiki.nested_syntaxes = { 'bash': 'bash', 'python': 'python' }
	let g:vimwiki_list = [wiki]
