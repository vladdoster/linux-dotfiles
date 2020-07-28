#!/bin/bash

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
SHELL="$(which bash)"
export SHELL=$SHELL   # required for sshrc tmux/screen integration
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
alias gsl='git log --decorate --graph --pretty=short'

#-- prompt --#
# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "[${BRANCH}${STAT}]"
	else
		echo ""
	fi
}

# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}

export PS1="\u\h\W\`parse_git_branch\` "
#-- history --#
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

#-- tmux session --#
alias tmux='tmux -f $SSHRC_DIR/tmux.conf'
if which tmux >/dev/null 2>&1; then
    session="main"
    # Check if the session exists, discarding output
    if tmux has-session -t "$session"; then
      tmux attach-session -t "$session"
    fi
    tmux new-session -s "$session"
fi
