" Author: Vlad Doster <mvdoster@gmail.com>
" Date: 2020-06-26 09:33:39
" Last Modified by: Vlad Doster <mvdoster@gmail.com>
" Last Modified time: 2020-07-01 18:10:43

if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')
  "=================
  "=  Programming  =
  "=================
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'preservim/nerdcommenter'
  Plug 'sheerun/vim-polyglot'
  " python
  Plug 'heavenshell/vim-pydocstring', { 'do': 'make install' }
  Plug 'tell-k/vim-autoflake'
  Plug 'tell-k/vim-autopep8'
  " sh
  Plug 'z0mbix/vim-shfmt', { 'for': 'sh' }
  "=================
  "=  Vim related  =
  "=================
  Plug 'vladdoster/vim-fileheader'
  Plug 'airblade/vim-gitgutter'
  Plug 'airblade/vim-rooter'
  Plug 'alvan/vim-closetag'
  Plug 'glts/vim-radical'
  Plug 'jiangmiao/auto-pairs'
  Plug 'junegunn/vim-easy-align'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'lilydjwg/colorizer'
  Plug 'liuchengxu/vim-which-key'
  Plug 'mhinz/vim-startify'
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-sleuth'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-vinegar'
  Plug 'unblevable/quick-scope'
  Plug 'vimwiki/vimwiki'
  Plug 'voldikss/vim-floaterm'
  "==============
  "=  Cosmetic  =
  "==============
  Plug 'gruvbox-community/gruvbox'
  Plug 'phanviet/vim-monokai-pro'
  Plug 'ryanoasis/vim-devicons'
  Plug 'sainnhe/gruvbox-material'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
call plug#end()
" Install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif
