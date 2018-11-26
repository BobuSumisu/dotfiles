#!/bin/bash
cd "$(dirname ${BASH_SOURCE[0]})"
BASE_DIR=$(pwd)

DOTFILES=(
    bashrc
    bin
    config/alacritty
    config/i3
    config/kitty
    gdbinit
    gitconfig
    i3status.conf
    profile
    tmux.conf
    tmuxinator
    vimrc
    Xresources
)

function install_file() {
    if [[ -L ~/.$1 ]] && [[ $(realpath ~/.$1) -ef $BASE_DIR/$1 ]]; then
        echo "[IGNORE] already installed: ~/.$1"
        return
    fi

    if [[ -e ~/.$1 ]] || [[ -L ~/.$1 ]]; then
        echo "[BACKUP] file already exists: ~/.$1"
        mv -v ~/.$1 backup/
    fi

    echo "[LINK] ~/.$1 --> $BASE_DIR/$1"
    ln -s $BASE_DIR/$1 ~/.$1
}

function install() {
    mkdir -vp backup

    for filename in ${DOTFILES[@]}; do
        install_file $filename
    done
}

install

unset BASE_DIR
unset DOTFILES
unset install_file
unset install_dir
unset install
