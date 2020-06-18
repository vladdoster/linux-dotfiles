syntax enable                          
" backup
set nobackup                           
set nowritebackup                      
" color scheme
colorscheme gruvbox                    
set guifont=Source\ Code\ Pro
set t_Co=256                           
set background=dark                    
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
set autochdir                          
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

autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
autocmd BufRead,BufNewFile *.tex set filetype=tex
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
