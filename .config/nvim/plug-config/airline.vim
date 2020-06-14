" gruvbox goodness
let g:airline_theme = 'gruvbox'

set showtabline=2
set noshowmode

" sections
let g:airline_section_a = "vim"
let g:airline_section_c = ''
let g:airline_section_y = ''

" enable tabline
let g:airline#extensions#tabline#enabled = 1

" disable tabline close button
let g:airline#extensions#tabline#show_close_button = 0

" show file name
let g:airline#extensions#tabline#fnamemod = ':t'

" misc.
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''
let airline#extensions#tabline#show_splits = 0
let airline#extensions#tabline#tabs_label = ''
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#fnamecollapse = 1
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#buffers_label = ''
let g:airline#extensions#tabline#tabs_label = ''
