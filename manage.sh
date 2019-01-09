#!/bin/bash
cd "$(dirname ${BASH_SOURCE[0]})"
BASE_DIR=$(pwd)

usage() {
    echo "Usage: manage.sh [OPTION...] ACTION..."
    echo ""
    echo "OPTIONS:"
    echo "    -v, --verbose         increase verbosity"
    echo "    -h, --help            show usage information"
    echo ""
    echo "ACTIONS:"
    echo "    install               install dotfiles"
    echo "    update                update subtrees"
}

install_dotfiles() {
    if [[ $(dpkg -l stow 1>/dev/null) = 1 ]]; then
        sudo apt install stow
    fi
    stow --verbose --restow --target=$HOME --ignore README.md --ignore tags --ignore install.sh .

    # build and install vim
    cd $BASE_DIR/3rd/vim
    ./configure \
        --prefix=$HOME/.local \
        --enable-luainterp \
        --enable-perlinterp \
        --enable-python3interp \
        --enable-tclinterp \
        --enable-rubyinterp \
        --enable-terminal
    cd $BASE_DIR/3rd/vim/src
    make -j$(nproc)
    sudo make install
    cd $BASE_DIR
}

update() {
    git subtree pull --prefix 3rd/vim https://github.com/vim/vim.git master --squash
}

main() {
    install=0
    update=0

    while [[ $1 != "" ]]; do
        case $1 in
            -h|--help)
                usage
                exit 0
                ;;
            -v|--verbose)
                ;;
            update)
                update=1
                ;;
            install)
                install=1
                ;;
            *)
                usage
                exit 1
                ;;
        esac
        shift
    done

    if [[ $update = 1 ]]; then
        update
    fi

    if [[ $install = 1 ]]; then
        install_dotfiles
    fi
}

main $@
