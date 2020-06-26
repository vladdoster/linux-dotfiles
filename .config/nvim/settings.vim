" @Author: Vlad Doster <mvdoster@gmail.com>
" @Date: 2020-06-23 08:17:13
" @Last Modified by: Vlad Doster <mvdoster@gmail.com>
" @Last Modified time: 2020-06-26 09:02:28

syntax enable                          
" backup
set nobackup                           
set nowritebackup                      
" color scheme
colorscheme gruvbox                    
set t_Co=256                           
set background=dark                    
" font
let &guifont='Source Code Pro 12'
" encoding
set encoding=utf-8                     
set fileencoding=utf-8                 
" indentation
set autoindent                         
set shiftwidth=2                       
set smartindent                        
" splits
set splitbelow                         
set splitright                         
" tabs 
set expandtab                          
set showtabline=2                      
set smarttab                           
set tabstop=2                          
" misc.
set clipboard=unnamedplus              
set cmdheight=2                        
set conceallevel=0                     
set cursorline                         
set hidden                             
set iskeyword+=-                       
set laststatus=2                       
set mouse=a                            
set noshowmode                         
set nowrap                             
set pumheight=10                       
set relativenumber                     
set ruler                              
set shortmess+=c                       
set signcolumn=yes                     
set timeoutlen=1000                   
set updatetime=50                      

autocmd BufRead,BufNewFile *.md,*.markdown set filetype=markdown
autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
autocmd BufRead,BufNewFile *.tex set filetype=tex
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
