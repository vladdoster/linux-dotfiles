#!/usr/bin/env zsh
 
# @Author: Vlad Doster <mvdoster@gmail.com>
# @Date: 2020-06-23 03:25:02
# @Last Modified by: Vlad Doster <mvdoster@gmail.com>
# @Last Modified time: 2020-07-21 03:09:16

# -- aliases & shortcuts -- #
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/user-dirs.dirs" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/user-dirs.dirs" # Linux
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shortcutrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shortcutrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/aliasrc"

# -- zsh history -- #
setopt HIST_IGNORE_DUPS   # don't add cmd to history if it's the same as the previous cmd
setopt INC_APPEND_HISTORY # each line is added to the history in this way as it is executed
HISTSIZE=30000            # max num lines
SAVEHIST=30000            # num save 30,000 commands
HISTFILE="${ZDOTDIR:-$HOME/.config/zsh}/.history" # history file location

# -- zsh prompt -- #
autoload -U colors && colors  # enable colors
setopt PROMPT_SUBST    # enable custom prompt
autoload -Uz vcs_info  # load vcs_info function
precmd() { vcs_info }  # call vcs info
zstyle ':vcs_info:git:*' formats '(%b)'  # only want current branch
PROMPT='%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[cyan]%}%~%{$fg[blue]%}${vcs_info_msg_0_}%{$fg[red]%}]%{$reset_color%}$ %b'

# -- zshell related -- #
export LANG=en_US.UTF-8  # set language locale
setopt AUTOCD            # if directory, change to it automatically
stty start undef         # unbind un-freeze keymap
stty stop undef          # unbind freeze keymap

# --- zsh key bindings --- #
bindkey -s '^a' 'bc -l\n'                    # open calculator
bindkey -s '^f' 'cd "$(dirname "$(fzf)")"\n' # fuzzy search a directory
bindkey '^[[P' delete-char

# - zsh syntax highlighting - #
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null

# -- zsh commands completion -- #
autoload -U compinit                # auto-load completion system
zstyle ':completion:*' menu select  # style of results
zmodload zsh/complist               # how to list possible completions
compinit                            # initialize completion for the current session
_comp_options+=(globdots)           # include hidden files

# --- zsh completion vim bindings --- #
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# -- vim mode -- #
bindkey -v
export KEYTIMEOUT=1

function zle-keymap-select {       # cursor shape for vi modes
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}

echo -ne '\e[5 q'                 # beam cursor on startup
preexec() { echo -ne '\e[5 q' ;}. # beam cursor for each new prompt
zle -N zle-keymap-select
zle-line-init() {                 # key binding to enter insert mode 
    zle -K viins
    echo -ne "\e[5 q"
}
zle -N zle-line-init

# - edit line in vim with ctrl-e - #
autoload edit-command-line 
zle -N edit-command-line
bindkey '^e' edit-command-line

# -- pyenv -- #
export PYENV_ROOT="$HOME/.pyenv" # Linux
export PATH="$PYENV_ROOT/bin:$PATH" # Linux
# export PYENV_VIRTUALENV_DISABLE_PROMPT=0 # venv prompt

if command -v pyenv 1>/dev/null 2>&1; then        # Linux
  eval "$(pyenv init -)"                          # Linux
  eval "$(pyenv virtualenv-init -)"               # Linux
fi                                                # Linux
source "${ZDOTDIR:-$HOME/.config/zsh}/pyenv.zsh"  # Linux

