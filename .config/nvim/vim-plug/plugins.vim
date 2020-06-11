" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')
  " Auto indent settings  
  Plug 'tpope/vim-sleuth'
  " Auto pairs for '(' '[' '{'   
  Plug 'jiangmiao/auto-pairs'
  " Autopep8
  Plug 'tell-k/vim-autopep8'
  " Better Comments  
  Plug 'preservim/nerdcommenter'
  " Closetags  
  Plug 'alvan/vim-closetag'
  " Code completion  
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  " Convert binary, hex, etc..  
  Plug 'glts/vim-radical'
  " Docstring generator
  Plug 'heavenshell/vim-pydocstring', { 'do': 'make install' }
  " Files  
  Plug 'tpope/vim-eunuch'
  " Fuzzy finder  
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  " Git  
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-fugitive'
  " Multi-language syntax support  
  Plug 'sheerun/vim-polyglot'
  " Tmux and nvim have a child
  " Repeat stuff  
  Plug 'tpope/vim-repeat'
  " See what keys do like in emacs  
  Plug 'liuchengxu/vim-which-key'
  " Self aware file system  
  Plug 'airblade/vim-rooter'
  " Shell file formatting
  Plug 'z0mbix/vim-shfmt', { 'for': 'sh' }
  " Start Screen  
  Plug 'mhinz/vim-startify'
  " Surround  
  Plug 'tpope/vim-surround'
  " Terminal  
  Plug 'voldikss/vim-floaterm'
  " Text Navigation  
  Plug 'unblevable/quick-scope'
  " Vim Wiki  
  Plug 'https://github.com/vimwiki/vimwiki.git'
  " Vim Vinegar
  Plug 'tpope/vim-vinegar'
  " ================
  " COSMETIC
  " ================
  " Cool Icons  
  Plug 'ryanoasis/vim-devicons'
  " Status Line  
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  " Theme  
  Plug 'gruvbox-community/gruvbox'
  Plug 'phanviet/vim-monokai-pro'
  Plug 'sainnhe/gruvbox-material'

call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif
