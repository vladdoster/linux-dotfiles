syntax enable                           " Enables syntax highlighing
" Backup related
set nobackup                            " Recommended by coc
set nowritebackup                       " This is recommended by coc
" Color scheme related
colorscheme gruvbox                     " groooovvvyyyyyyy
set guifont=Source\ Code\ Pro
set t_Co=256                            " Support 256 colors
set background=dark                     " tell vim what the background color looks like
" Encoding related
set encoding=utf-8                      " The encoding displayed 
set fileencoding=utf-8                  " The encoding written to file
" Indent related
set autoindent                          " Good auto indent
set shiftwidth=2                        " Change the number of space characters inserted for indentation
set smartindent                         " Makes indenting smart
" Split related
set splitbelow                          " Horizontal splits will automatically be below
set splitright                          " Vertical splits automatically to the right
" Tab related
set expandtab                           " Converts tabs to spaces
set showtabline=2                       " Always show tabs 
set smarttab                            " Makes tabbing smarter will realize you have 2 vs 4
set tabstop=2                           " Insert 2 spaces for a tab

set iskeyword+=-                      	" treat dash separated words as a word text object
set formatoptions-=cro                  " Stop newline continution of comments
set clipboard=unnamedplus               " Copy paste between vim and everything else
set cmdheight=2                         " More space for messages
set conceallevel=0                      " So that I can see `` in markdown files
set cursorline                          " Enable highlighting of the current line
set hidden                              " Required to keep multiple buffers open multiple buffers
set laststatus=2                        " Always display status line
set mouse=a                             " Enable mouse
set noshowmode                          
set nowrap                              " Display long lines as just one line
set relativenumber                      
set pumheight=10                        " Makes popup menu smaller
set ruler              			            " Show the cursor position all the time
set shortmess+=c                        " Don't pass messages to |ins-completion-menu|.
set signcolumn=yes                      " Always show the signcolumn, otherwise it would shift the text each time
set timeoutlen=1000                     " By default timeoutlen is 1000 ms
set updatetime=50                       " Faster completion
set autochdir                           " Your working directory will always be the same as your working directory

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

