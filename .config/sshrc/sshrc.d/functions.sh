#!/bin/bash
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

# Start tmux and source sshrc bash
tmuxrc() {
  local TMUXDIR=/tmp/tmux-ssh-home
  if ! [ -d $TMUXDIR ]; then
    rm -rf $TMUXDIR
    mkdir -p $TMUXDIR
  fi
  rm -rf $TMUXDIR/.sshrc.d
  cp -r $SSHHOME/.sshrc $SSHHOME/bashsshrc $SSHHOME/sshrc $SSHHOME/.sshrc.d $TMUXDIR
  SSHHOME=$TMUXDIR SHELL=$TMUXDIR/bashsshrc tmux -f $TMUXDIR/.sshrc.d/.tmux.conf $@
}

# Create or attach a screenrc session
screenrc-create-or-attach-session() {
  screenrc -xRR
}

# Create or attach a tmuxrc session
tmuxrc-create-or-attach-session() {
  local TMUX_SESSION_NAME="auto"

  if tmux has-session -t $TMUX_SESSION_NAME >/dev/null 2>&1; then
    tmuxrc -2CC attach-session -t $TMUX_SESSION_NAME
  else
    tmuxrc -2CC new-session -s $TMUX_SESSION_NAME
  fi
}

# Set tmux window title
tmux-title() {
  tmux rename-window $@
}

# Find which ports a process is listening on
whichport() {
  ss -l -p -n | grep $1
}
