#!/usr/bin/env bash

HACK_URL=http://no.archive.ubuntu.com/ubuntu/pool/universe/f/fonts-hack/fonts-hack-ttf_2.019-1_all.deb

main() {
    install_packages
    setup_git
    install_dotfiles
    setup_vim
}

install_packages() {
    sudo apt-get install git stow unzip vim-nox build-essential cmake python-dev rxvt-unicode-256color
    sudo apt-get install fonts-hack-ttf || {
        wget $HACK_URL -O fonts-hack-ttf.deb
        sudo dpkg -i fonts-hack-ttf.deb
        rm fonts-hack-ttf.deb
    }
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
