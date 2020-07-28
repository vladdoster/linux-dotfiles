#!/bin/bash

# if running bash
if [ -n "$BASH_VERSION" ]; then
    if [ -f "$SSHRC_DIR"/.bashrc ]; then
        source "$SSHRC_DIR"/.bashrc
    fi
fi
