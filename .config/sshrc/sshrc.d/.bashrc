#!/bin/bash

SHELL="$(which bash)"
export EDITOR=vim
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export MYVIMRC="$REMOTE_SSHRC_CONFIGS_DIR"/.vimrc
export SHELL=$SHELL # required for sshrc tmux/screen integration
export VISUAL=vim
source "$REMOTE_SSHRC_CONFIGS_DIR"/.git-completion.bash

#-- aliases --#
#-> PROGRAMS
git --file "$REMOTE_SSHRC_CONFIGS_DIR"/.git-config
alias vim="vim -i NONE -u '$REMOTE_SSHRC_CONFIGS_DIR'/.vimrc"
#-> MISC.
alias ..='cd ..'                             # make .. go up a folder
alias mkdir='mkdir -p'                       # creat dirs recursively
alias path='echo $PATH | tr ":" "\n" | sort' # print $path nicely

#-- prompt --#
export PS1="[\u@\h \W \`parse_git_branch\`]$ "

#-- history --#
export HISTCONTROL=ignoredups:erasedups # Avoid duplicates
export HISTFILE="${HOME:-/tmp}"/.bash_history
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"
shopt -s histappend # append to the history file instead of overwriting it

#-- autocorrect typos in path names when using `cd` --#
shopt -s cdspell

#-- gnutar as tar, for sshrc warnings --#
if [ -e "/usr/local/opt/gnu-tar/libexec/gnubin/tar" ]; then
  export PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
fi
