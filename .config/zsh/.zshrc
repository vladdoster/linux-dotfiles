#--- Zoomer Shell ---#

# Enable colors and change prompt:
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
setopt autocd	# Automatically cd into typed directory.
stty stop undef	# Disable ctrl-s to freeze terminal.

# History in cache directory:
HISTSIZE=30000
SAVEHIST=30000
HISTFILE="${ZDOTDIR}/history"

# Load aliases and shortcuts
[ -f "$XDG_CONFIG_HOME/user-dirs.dirs" ] && source "$XDG_CONFIG_HOME/user-dirs.dirs"
[ -f "$XDG_CONFIG_HOME/shortcutrc" ] && source "$XDG_CONFIG_HOME/shortcutrc"
[ -f "$XDG_CONFIG_HOME/aliasrc" ] && source "$XDG_CONFIG_HOME/aliasrc"

# auto/tab complete
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots) # Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# vim keys in tab complete menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# cursor shape for different vi modes
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
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap
    echo -ne "\e[5 q"
}

zle -N zle-line-init
echo -ne '\e[5 q' # beam cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # beam cursor for each new prompt.

# Beam cursor on startup
echo -ne '\e[5 q'
# Beam cursor for each new prompt
preexec() { echo -ne '\e[5 q' ;}

bindkey -s '^a' 'bc -l\n'
bindkey -s '^f' 'cd "$(dirname "$(fzf)")"\n'
bindkey '^[[P' delete-char

# Edit line in vim with ctrl-e
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Load syntax highlighting
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null
