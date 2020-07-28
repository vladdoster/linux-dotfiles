#!/bin/bash

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export SHELL=`which bash` # required for sshrc tmux/screen integration

#-- history --#
# Avoid duplicates
export HISTCONTROL=ignoredups:erasedups
# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend
# After each command, append to the history file and reread it
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# prompt
export GIT_PS1_SHOWDIRTYSTATE=1
export PS1='\w$(__git_ps1 " (%s)")\$ '
