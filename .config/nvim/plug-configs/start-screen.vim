autocmd User Startified setlocal cursorline

let g:startify_custom_header = 'startify#pad(startify#fortune#boxed())'

let g:startify_enable_special      = 0
let g:startify_files_number        = 10
let g:startify_relative_path       = 1
let g:startify_change_to_dir       = 1
let g:startify_update_oldfiles     = 1
let g:startify_session_autoload    = 1
let g:startify_session_persistence = 1
let g:startify_session_dir = '~/.config/nvim/session'
let g:startify_session_delete_buffers = 1

hi! link StartifyHeader Normal
hi! link StartifyFile Directory
hi! link StartifyPath LineNr
hi! link StartifySlash StartifyPath
hi! link StartifyBracket StartifyPath
hi! link StartifyNumber Title

function! s:lsGithubDir()
let files = systemlist('ls -d ~/github/* 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

function! s:lsCwd()
    let files = systemlist('function(getcwd())')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

let g:startify_lists = [
          \ { 'type': 'files',                    'header': ['   Recent files']},
          \ { 'type': 'files',                    'header': ['   Current Directory: '.getcwd()]},
          \ { 'type': function('s:lsGithubDir'),  'header': ['   Github projects']},
          \ { 'type': 'sessions',                 'header': ['   Sessions']},
          \ { 'type': 'bookmarks',                'header': ['   Bookmarks']},
          \ ]

let g:startify_bookmarks = [
            \ { 'D': '~/documents/' },
            \ { 'c': '~/.config' },
            \ { 'd': '~/downloads/' },
            \ { 'i': '~/.config/nvim/init.vim' },
            \ { 's': '~/.local/src/' },
            \ { 'w': '~/.local/src/vimwiki.git/index.wiki' },
            \ { 'z': '~/.config/zsh/zshrc' },
            \ ]

