#!/usr/bin/env zsh

# Author: Vlad Doster <mvdoster@gmail.com>
# Date: 2020-07-06 14:20:50
# Last Modified by: Vlad Doster <mvdoster@gmail.com>
# Last Modified time: 2020-07-24 12:28:37

# --- default programs --- #
export EDITOR="nvim"
export TERMINAL="st"      # Linux
export BROWSER="firefox"
export READER="zathura"   # Linux

# --- system variables --- #
export XDG_CACHE_HOME="${HOME}/.cache"    # Linux
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_USER_LOCAL="${HOME}/.local"    # Linux
export XDG_DATA_HOME="${XDG_USER_LOCAL:-$HOME/.local}/share"
export XDG_USER_BINARIES="${XDG_USER_LOCAL:-$HOME/.local}/bin"  # Linux

# -- add `~/.local/bin` to $PATH -- #
export PATH="$PATH:$(du "${XDG_USER_BINARIES}" | cut -f2 | paste -sd ':')"  # Linux

# --- X11 --- #
export XAUTHORITY="${XDG_RUNTIME_DIR}/Xauthority"  # Linux
export XINITRC="${XDG_CONFIG_HOME}/X11/xinitrc"    # Linux

# ---  $HOME clean-up --- #
# Cache
export CUDA_CACHE_PATH="${XDG_CACHE_HOME}/nv"  # Linux
export PYLINTHOME="${XDG_CACHE_HOME}/pylint"  # Linux
export PYTHON_EGG_CACHE="${XDG_CACHE_HOME}/python-eggs"  # Linux
# Configs
export AWS_CONFIG_FILE="${XDG_CONFIG_HOME}/aws/config"  # Linux
export AWS_SHARED_CREDENTIALS_FILE="${XDG_CONFIG_HOME}/aws/credentials"  # Linux
export DOCKER_CONFIG="${XDG_CONFIG_HOME}/docker"  # Linux
export GTK_RC_FILES="${XDG_CONFIG_HOME}/gtk-1.0/gtkrc"  # Linux
export GTK2_RC_FILES="${XDG_CONFIG_HOME}/gtk-2.0/gtkrc"  # Linux
export INPUTRC="${XDG_CONFIG_HOME}/inputrc"  # Linux
export IPYTHONDIR="${XDG_CONFIG_HOME}/jupyter"  # Linux
export JUPYTER_CONFIG_DIR="${XDG_CONFIG_HOME}/jupyter"  # Linux
export NOTMUCH_CONFIG="${XDG_CONFIG_HOME}/notmuch-config"  # Linux
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"  # Linux
export PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/startup"
export WGETRC="${XDG_CONFIG_HOME}/wget/wgetrc"  # Linux
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
# Data
export CARGO_HOME="${XDG_DATA_HOME}/cargo"                     # Linux
export GNUPGHOME="${XDG_DATA_HOME}/gnupg"                      # Linux
export GOPATH="${XDG_DATA_HOME}/go"                            # Linux
export MACHINE_STORAGE_PATH="${XDG_DATA_HOME}/docker-machine"  # Linux
export NVM_DIR="${XDG_DATA_HOME}/nvm"                          # Linux
export PASSWORD_STORE_DIR="${XDG_DATA_HOME}/password-store"    # Linux
# Runtime
export TMUX_TMPDIR="${XDG_RUNTIME_DIR}"                        # Linux

# --- misc. program settings --- #
export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"
export LESS=-R
export LESSHISTFILE="-"
export LESSOPEN="| /usr/bin/highlight -O ansi %s 2>/dev/null"
export LESS_TERMCAP_mb="$(printf '%b' '[1;31m')"
export LESS_TERMCAP_md="$(printf '%b' '[1;36m')"
export LESS_TERMCAP_me="$(printf '%b' '[0m')"
export LESS_TERMCAP_so="$(printf '%b' '[01;44;33m')"
export LESS_TERMCAP_se="$(printf '%b' '[0m')"
export LESS_TERMCAP_us="$(printf '%b' '[1;32m')"
export LESS_TERMCAP_ue="$(printf '%b' '[0m')"
export QT_QPA_PLATFORMTHEME="gtk2"	                      # Linux
export SUDO_ASKPASS="${XDG_USER_LOCAL}/bin/dmenu_pass"   # Linux
export _JAVA_AWT_WM_NONREPARENTING=1	# Java doesn't understand tiling windows

# --- generate shortcuts --- #
[ ! -f "${XDG_CONFIG_HOME}/shortcutrc" ] && generate_shortcutrc >/dev/null 2>&1 &

# --- make shortcuts available in `get_bindings` program --- #
ln -s "${XDG_CONFIG_HOME:-$HOME/.config}/directories" "${XDG_DATA_HOME:-$HOME/.local/share/dotfiles/program_bindings_help}/directories"   # Linux
ln -s "${XDG_CONFIG_HOME:-$HOME/.config}/files" "${XDG_DATA_HOME:-$HOME/.local/share/dotfiles/program_bindings_help}/files"               # Linux

# --- start graphical server on tty1 if not already running --- #
[ "$(tty)" = "/dev/tty1" ] && ! ps -e | grep -qw Xorg && exec startx "${XINITRC}"  # Linux

# --- remap keys in ttys --- #
sudo -n loadkeys "${XDG_DATA_HOME}/dotfiles/tty_remaps.kmap" 2>/dev/null    # Linux
