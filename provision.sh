#!/usr/bin/env bash

main() {
    install_packages
    setup_git
    install_dotfiles
    setup_vim
}

install_packages() {
    sudo apt-get install git stow unzip vim-nox build-essential cmake python-dev rxvt-unicode-256color fonts-inconsolata
}

setup_git() {
    git submodule init
    git submodule update
}

install_dotfiles() {
    stow -v -R -t $HOME         \
        --ignore='\.'           \
        --ignore='\.git.*'      \
        --ignore='README.md'    \
        --ignore='provision.sh' \
        .
}

setup_vim() {
    vim +NeoBundleInstall +qall
    pushd . > /dev/null
    cd .vim/bundle/YouCompleteMe
    ./install.py --clang-completer
    popd > /dev/null
}

main $@
