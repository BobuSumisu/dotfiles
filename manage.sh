#!/bin/bash
cd "$(dirname ${BASH_SOURCE[0]})"

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
