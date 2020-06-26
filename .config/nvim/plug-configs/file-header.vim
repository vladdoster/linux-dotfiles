" Author: Vlad Doster <mvdoster@gmail.com>
" Date: 2020-06-26 09:34:32
" Last Modified by: Vlad Doster <mvdoster@gmail.com>
" Last Modified time: 2020-06-26 09:34:36

let g:fileheader_auto_update = 1
let g:fileheader_auto_add = 1
let g:fileheader_delimiter_map = {
    \ 'python': { 'begin': "#!/usr/bin/env python3\n#-*- coding: utf-8 -*-\n ", 'char': '# ', 'end': '' },
    \ 'zsh':    { 'begin': "#!/usr/bin/env zsh\n ", 'char': '# ', 'end': '' },
    \ 'markdown':    { 'begin': "---", 'char': '', 'end': '---' },
    \ 'vimwiki':    { 'begin': "---", 'char': '', 'end': '---' },
    \ }

