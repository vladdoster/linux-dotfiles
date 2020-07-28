#!/bin/bash

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$SSHRC_DIR/.bashrc" ]; then
    . "$SSHRC_DIR/.bashrc"
    fi
fi
