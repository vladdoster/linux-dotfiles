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
