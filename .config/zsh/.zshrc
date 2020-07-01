#!/usr/bin/env zsh
 
# @Author: Vlad Doster <mvdoster@gmail.com>
# @Date: 2020-06-23 03:25:02
# @Last Modified by: Vlad Doster <mvdoster@gmail.com>
# @Last Modified time: 2020-07-01 17:02:50

#-> prompt color/text
autoload -U colors && colors

#-> load version control information
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '(%b)'
setopt PROMPT_SUBST
PROMPT='%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[cyan]%}%~%{$fg[blue]%}${vcs_info_msg_0_}%{$fg[red]%}]%{$reset_color%}$ %b'

setopt autocd	
stty stop undef

#-> history
HISTSIZE=30000
SAVEHIST=30000
HISTFILE="${ZDOTDIR:-$HOME/.config/zsh}/history"
#-> aliases and shortcuts
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/user-dirs.dirs" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/user-dirs.dirs"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shortcutrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shortcutrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/aliasrc"

#-> ZSH goodies
#-> _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"
#-> disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"
#-> display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"
#-> disable marking untracked files under VCS as dirty.
DISABLE_UNTRACKED_FILES_DIRTY="true"
#-> language environment
export LANG=en_US.UTF-8
# auto-tab complete
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
#-> Include hidden files
_comp_options+=(globdots)

#-> virtualenvwrapper
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

#-> vi mode
bindkey -v
export KEYTIMEOUT=1

#-> tab complete menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

#-> cursor shape for vi modes
function zle-keymap-select {
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

zle -N zle-keymap-select
#-> initiate `vi insert` as keymap
zle-line-init() {
    zle -K viins
    echo -ne "\e[5 q"
}
zle -N zle-line-init
#-> beam cursor on startup
echo -ne '\e[5 q'
#-> beam cursor for each new prompt
preexec() { echo -ne '\e[5 q' ;}
#-> beam cursor on startup
echo -ne '\e[5 q'
#-> beam cursor for each new prompt
preexec() { echo -ne '\e[5 q' ;}
bindkey -s '^a' 'bc -l\n'
bindkey -s '^f' 'cd "$(dirname "$(fzf)")"\n'
bindkey '^[[P' delete-char

#-> edit line in vim with ctrl-e
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

#-> syntax highlighting
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null

#-> pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
source $ZDOTDIR/pyenv.zsh

