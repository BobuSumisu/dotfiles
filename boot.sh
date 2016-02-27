#!/usr/bin/env bash

HACK_TTF_URL=https://github.com/chrissimpkins/Hack/releases/download/v2.019/Hack-v2_019-ttf.zip

main() {
    setup_git
}

setup_vim() {
    dpkg -s vim-nox > /dev/null 2>&1 || sudo apt-get install vim-nox
    vim +NeoBundleInstall +qall
    cd $HOME/.vim/bundle/YouCompleteMe
    ./install.py --clang-completer
}

setup_git() {
    dpkg -s git > /dev/null 2>&1 || sudo apt-get install git

    git remote -v | grep -i BobuSumisu/dotfiles > /dev/null && echo "nop"

    #git submodule init
    #git submodule update
}

main $@
