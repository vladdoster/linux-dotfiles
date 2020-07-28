#!/bin/bash

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export SHELL=`which bash` # required for sshrc tmux/screen integration

# Use gnutar as tar, for sshrc warnings
if [ -e "/usr/local/opt/gnu-tar/libexec/gnubin/tar" ]; then
  export PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
fi

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;
