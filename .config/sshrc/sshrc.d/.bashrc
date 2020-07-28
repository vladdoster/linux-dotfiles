#!/bin/bash

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
SHELL="$(which bash)"
export SHELL=$SHELL   # required for sshrc tmux/screen integration
export EDITOR=vim
export VISUAL=vim
export $MYVIMRC="$SSHRC_DIR"/.vimrc

#-- aliases --#
# misc.
alias path='echo $PATH | tr ":" "\n" | sort'    # print $path nicely
alias mkdir='mkdir -p'                          # creat dirs recursively
alias ..='cd ..'                                # make .. go up a folder
# git
alias gs='git status'
alias ga='git add -A'
alias gp='git push origin HEAD'
alias gd='git difftool'
alias gc='git commit -m'
alias gsl='git log --decorate --graph --pretty=short'

#-- prompt --#
export PS1="[\u@\h \W \`parse_git_branch\`]$ "

#-- history --#
export HISTFILE="$SSHRC_DIR"/.bash_history
export HISTCONTROL=ignoredups:erasedups  # Avoid duplicates
shopt -s histappend  # append to the history file instead of overwriting it
# After each command, append to the history file and reread it
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

#-- autocorrect typos in path names when using `cd` --#
shopt -s cdspell;

#-- gnutar as tar, for sshrc warnings --#
if [ -e "/usr/local/opt/gnu-tar/libexec/gnubin/tar" ]; then
  export PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
fi
