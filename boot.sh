#!/usr/bin/env bash

DOTFILES_REPO=https://github.com/BobuSumisu/dotfiles.git
DOTFILES_DIR=
HACK_DEB=fonts-hack-ttf_2.019-1_all.deb
HACK_DEB_URL=http://no.archive.ubuntu.com/ubuntu/pool/universe/f/fonts-hack/$HACK_DEB

main() {
    install_packages
    setup_git
    install_dotfiles
    setup_vim
    setup_hack
}

install_packages() {
    sudo apt-get install git stow unzip vim-nox build-essential cmake python-dev rxvt-unicode-256color
    sudo apt-get install fonts-hack-ttf || {
        wget $HACK_DEB_URL
        sudo dpkg -i $HACK_DEB
        rm $HACK_DEB
    }
}

setup_git() {
    git clone https://github.com/BobuSumisu/dotfiles.git
    pusdh . > /dev/null
    cd dotfiles
    DOTFILES_DIR=$(pwd) 
    git submodule init
    git submodule update
    popd
}

install_dotfiles() {
    cd $DOTFILES_DIR
    stow -n -v -R -t $HOME      \
        --ignore='\.'           \
        --ignore='\.git.*'      \
        --ignore='README.md'    \
        --ignore='boot.sh'      \
        .
}

setup_vim() {
    vim +NeoBundleInstall +qall
    pushd . > /dev/null
    cd $HOME/.vim/bundle/YouCompleteMe
    ./install.py --clang-completer
    popd > /dev/null
}

main $@
