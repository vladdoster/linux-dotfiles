#!/bin/bash

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export SHELL=`which bash` # required for sshrc tmux/screen integration
export EDITOR=vim
export VISUAL=vim

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
alias gl='git log -n 20 --format="%ai  %Cgreen%h%Creset  %<(10,trunc)%aN  %s"'
alias gsl='git log --decorate --graph --pretty=short'

#-- history --#
export HISTCONTROL=ignoredups:erasedups  # Avoid duplicates
shopt -s histappend  # append to the history file instead of overwriting it
# After each command, append to the history file and reread it
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

#-- autocorrect typos in path names when using `cd` --#
shopt -s cdspell;

#-- prompt --#
export GIT_PS1_SHOWDIRTYSTATE=1
export PS1='\w$(__git_ps1 " (%s)")\$ '

#-- tmux session --#
if which tmux >/dev/null 2>&1; then
    session="main"
    # Check if the session exists, discarding output
    tmux has-session -t $session 2>/dev/null
    if [ $? != 0 ]; then
      # Set up your session
    fi
    tmux attach-session -t $session
fi

#-- gnutar as tar, for sshrc warnings --#
if [ -e "/usr/local/opt/gnu-tar/libexec/gnubin/tar" ]; then
  export PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
fi
