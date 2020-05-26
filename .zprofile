#!/bin/zsh

# Adds `~/.local/bin` to $PATH
export PATH="$PATH:$(du "$HOME/.local/bin/" | cut -f2 | paste -sd ':')"

# Default programs:
export EDITOR="nvim"
export TERMINAL="st"
export BROWSER="google-chrome-stable"
export READER="zathura"

# ~/ Clean-up:
export XDG_CACHE_HOME="${HOME}"/.cache
export XDG_CONFIG_HOME="${HOME}"/.config
export XDG_DATA_HOME="${HOME}/.local/share"
## Cache
export CUDA_CACHE_PATH="${XDG_CACHE_HOME}"/nv
export PYLINTHOME="${XDG_CACHE_HOME}"/pylint
export PYTHON_EGG_CACHE="${XDG_CACHE_HOME}"/python-eggs
## Config
export DOCKER_CONFIG="${XDG_CONFIG_HOME}"/docker
export GTK2_RC_FILES="${XDG_CONFIG_HOME}"/gtk-2.0/gtkrc-2.0
export INPUTRC="${XDG_CONFIG_HOME}"/inputrc
export IPYTHONDIR="${XDG_CONFIG_HOME}"/jupyter
export JUPYTER_CONFIG_DIR="${XDG_CONFIG_HOME}"/jupyter
export NOTMUCH_CONFIG="${XDG_CONFIG_HOME}"/notmuch-config
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}"/npm/npmrc
export PYTHONSTARTUP="${XDG_CONFIG_HOME}"/python/startup
export WGETRC="${XDG_CONFIG_HOME}"/wget/wgetrc
export XINITRC="${XDG_CONFIG_HOME}"/X11/xinitrc
export ZDOTDIR="${XDG_CONFIG_HOME}"/zsh
# Data
export CARGO_HOME="${XDG_DATA_HOME}"/cargo
export GNUPGHOME="${XDG_DATA_HOME}"/gnupg
export GOPATH="${XDG_DATA_HOME}"/go
export MACHINE_STORAGE_PATH="${XDG_DATA_HOME}"/docker-machine
export NVM_DIR="${XDG_DATA_HOME}"/nvm
export PASSWORD_STORE_DIR="${XDG_DATA_HOME}"/password-store
# Runtime
export TMUX_TMPDIR="${XDG_RUNTIME_DIR}"
export XAUTHORITY="${XDG_RUNTIME_DIR}"/Xauthority

# Misc. program settings:
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
export QT_QPA_PLATFORMTHEME="gtk2"	# Have QT use gtk2 theme.
export SUDO_ASKPASS="${HOME}/.local/bin/dmenu_pass"
export _JAVA_AWT_WM_NONREPARENTING=1	# Java doesn't understand tiling windows

[ ! -f "${XDG_CONFIG_HOME}"/shortcutrc ] && generate_shortcuts >/dev/null 2>&1 &

# Start graphical server on tty1 if not already running.
[ "$(tty)" = "/dev/tty1" ] && ! ps -e | grep -qw Xorg && exec startx "${XINITRC}"

# Switch escape and caps if tty and no passwd required:
sudo -n loadkeys "${XDG_DATA_HOME}"/dotfiles/ttymaps.kmap 2>/dev/null
