#!/usr/bin/env bash

DOTFILES_REPO=https://github.com/BobuSumisu/dotfiles.git
DOTFILES_DIR=$(pwd -P)

HACK_TTF_URL=https://github.com/chrissimpkins/Hack/releases/download/v2.019/Hack-v2_019-ttf.zip

main() {
    setup_git
    setup_vim
    setup_hack
    install_dotfiles
}

setup_vim() {
    dpkg -s vim-nox > /dev/null 2>&1 || sudo apt-get install vim-nox
    dpkg -s build-essential > /dev/null 2>&1 || sudo apt-get install build-essential
    dpkg -s cmake > /dev/null 2>&1 || sudo apt-get install cmake
    dpkg -s python-dev > /dev/null 2>&1 || sudo apt-get install python-dev

    vim +NeoBundleInstall +qall
    cd $DOTFILES_DIR/.vim/bundle/YouCompleteMe
    ./install.py --clang-completer

    cd $DOTFILES_DIR
}

setup_git() {
    dpkg -s git > /dev/null 2>&1 || sudo apt-get install git

    git remote -v > /dev/null 2>&1 | grep dotfiles || {
        git clone https://github.com/BobuSumisu/dotfiles.git
        cd dotfiles
        DOTFILES_DIR=$(pwd -P)
    }

    git submodule init
    git submodule update
}

setup_hack() {
    fc-list | grep -i Hack > /dev/null || {
        grep -R "^deb" /etc/apt/ | grep "unstable" && {
            dpkg -s fonts-hack-ttf > /dev/null 2>&1 || sudo apt-get install fonts-hack-ttf
            return
        }

        dpkg -s unzip > /dev/null 2>&1 || sudo apt-get install unzip
        wget $HACK_TTF_URL -o Hack-ttf.zip
        unzip Hack-ttf.zip -d /usr/share/fonts/truetype/hack
        fc-cache -s
    }
}

install_dotfiles() {
    dpkg -s stow > /dev/null 2>&1 || sudo apt-get install stow
    
    stow -n -v -R -t $HOME      \
        --ignore='\.'           \
        --ignore='\.git.*'      \
        --ignore='README.md'    \
        --ignore='boot.sh'      \
        .
}

main $@
