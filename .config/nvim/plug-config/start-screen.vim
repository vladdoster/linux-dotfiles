let g:startify_custom_header = 'startify#pad(startify#fortune#boxed())'

let g:startify_session_dir = '~/.config/nvim/session'

function! s:lsGithubDir()
    let files = systemlist('ls -d ~/github/* 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

let g:startify_lists = [
          \ { 'type': 'files',                    'header': ['Files']},
          \ { 'type': function('s:lsGithubDir'),  'header': ['Github projects']},
          \ { 'type': 'sessions',                 'header': ['Sessions']},
          \ { 'type': 'bookmarks',                'header': ['Bookmarks']},
          \ ]

let g:startify_bookmarks = [
            \ { 'c': '~/.config' },
            \ { 'i': '~/.config/nvim/init.vim' },
            \ { 'z': '~/.config/zsh/zshrc' },
            \ { 's': '~/.local/src/' },
            \ ]

let g:startify_change_to_vcs_root = 1
let g:startify_enable_special = 0
let g:startify_fortune_use_unicode = 1
let g:startify_session_autoload = 1
let g:startify_session_delete_buffers = 1
let g:startify_session_persistence = 1
