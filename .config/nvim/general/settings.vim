syntax enable                           " Enables syntax highlighing
colorscheme gruvbox                     " groooovvvyyyyyyy
cmap w!! w !sudo tee %                  " god mode save
set iskeyword+=-                      	" treat dash separated words as a word text object
set formatoptions-=cro                  " Stop newline continution of comments
set autoindent                          " Good auto indent
set background=dark                     " tell vim what the background color looks like
set clipboard=unnamedplus               " Copy paste between vim and everything else
set cmdheight=2                         " More space for messages
set conceallevel=0                      " So that I can see `` in markdown files
set cursorline                          " Enable highlighting of the current line
set encoding=utf-8                      " The encoding displayed 
set expandtab                           " Converts tabs to spaces
set fileencoding=utf-8                  " The encoding written to file
set guifont=Source\ Code\ Pro
set hidden                              " Required to keep multiple buffers open multiple buffers
set incsearch
set laststatus=2                        " Always display status line
set mouse=a                             " Enable mouse
set nobackup                            " Recommended by coc
set noshowmode                          
set nowrap                              " Display long lines as just one line
set nowritebackup                       " This is recommended by coc
set relativenumber                      
set pumheight=10                        " Makes popup menu smaller
set ruler              			            " Show the cursor position all the time
set shiftwidth=2                        " Change the number of space characters inserted for indentation
set shortmess+=c                        " Don't pass messages to |ins-completion-menu|.
set showtabline=2                       " Always show tabs 
set signcolumn=yes                      " Always show the signcolumn, otherwise it would shift the text each time
set smartindent                         " Makes indenting smart
set smarttab                            " Makes tabbing smarter will realize you have 2 vs 4
set splitbelow                          " Horizontal splits will automatically be below
set splitright                          " Vertical splits automatically to the right
set t_Co=256                            " Support 256 colors
set tabstop=2                           " Insert 2 spaces for a tab
set timeoutlen=100                      " By default timeoutlen is 1000 ms
set updatetime=50                       " Faster completion
set autochdir                           " Your working directory will always be the same as your working directory

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
