" VimWiki

" Filetypes enabled for
let g:vimwiki_filetypes = ['wiki']

let g:vimwiki_list = [{'path': '~/.local/src/vimwiki.git/',
                      \ 'syntax': 'markdown', 'ext': '.md', 'exclude_files': ['**/README.md', '**/Readme.md'] }]

let g:vimwiki_auto_header = 1
let g:vimwiki_auto_chdir = 0

let g:vimwiki_diary_months = {
      \ 1: 'January', 2: 'February', 3: 'March',
      \ 4: 'April', 5: 'May', 6: 'June',
      \ 7: 'July', 8: 'August', 9: 'September',
      \ 10: 'October', 11: 'November', 12: 'December'
      \ }
