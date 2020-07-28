#!/bin/bash

# if running bash
if [ -f "$SSHRC_DIR"/.bashrc ]; then
  source "$SSHRC_DIR"/.bashrc
  echo "Sourced .bash_profile"
fi
