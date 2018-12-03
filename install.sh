#!/bin/bash
cd "$(dirname ${BASH_SOURCE[0]})"
BASE_DIR=$(pwd)

DOTFILES=(
    bashrc
    bin
    config/alacritty
    config/i3
    config/kitty
    config/pep8
    config/pylintrc
    config/user-dirs.dirs
    gdbinit
    gitconfig
    i3status.conf
    profile
    tmux.conf
    tmuxinator
    vimrc
    Xresources
)

SIMULATE=false
UNINSTALL=false
VERBOSE=false

debug() {
    $VERBOSE && echo "[DEBUG] $1"
}

panic() {
    echo -e "\e[31m[ERROR] $1\e[0m"
    exit 1
}

usage() {
    echo "Usage: install.sh [OPTION]..."
    echo ""
    echo "OPTIONS"
    echo ""
    echo "  -s, --simulate      simulate (no filesystem changes)"
    echo "  -u, --uninstall     remove symlinks"
    echo "  -v, --verbose       increase verbosity"
    echo "  -h, --help          show this help info"
}

install() {
    debug "creating backup directory"
    $SIMULATE || mkdir -p backup

    for f in ${DOTFILES[@]}; do
        local src=$BASE_DIR/$f
        local dst=~/.$f

        if [[ -L $dst ]] && [[ $(realpath $dst) -ef $src ]]; then
            debug "ignoring already installed file: $dst"
        else
            if [[ -e $dst ]] || [[ -L $dst ]]; then
                debug "backing up file: $dst"
                $SIMULATE || mv $dst backup/
            fi
            debug "setting up link: $src -> $dst"
            $SIMULATE || ln -s $src $dst
        fi
    done

    if [[ -z $(ls -A backup 2>/dev/null) ]]; then
        debug "backup directory empty, removing it"
        $SIMULATE || rmdir backup
    else
        debug "compressing backup directory"
        $SIMULATE || tar -czf backup-$(date -I).tgz backup
    fi

    if [[ ! -f ~/.vim/autoload/plug.vim ]]; then
        debug "fetching plug.vim and installing plugins"
        if !$SIMULATE; then
            curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
                https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
            vim +PlugInstall
        fi
    else
        debug "plug.vim already installed"
    fi
}

uninstall() {
    for f in ${DOTFILES[@]}; do
        local src=$BASE_DIR/$f
        local dst=~/.$f

        if [[ -L $dst ]] && [[ $(realpath $dst) -ef $src ]]; then
            debug "uninstalling $dst"
            $SIMULATE || unlink $dst
        else
            panic "file is not installed: $dst"
        fi
    done
}

main() {

    while [[ $# -gt 0 ]]; do
        case $1 in
            -s|--simulate)
                SIMULATE=true
                shift
                ;;
            -u|--uninstall)
                UNINSTALL=true
                shift
                ;;
            -v|--verbose)
                VERBOSE=true
                shift
                ;;
            -h|--help)
                usage
                exit 0
                ;;
            *)
                usage
                exit 1
                ;;
        esac
    done

    if $UNINSTALL; then
        uninstall || panic "uninstall failed"
    else
        install || panic "install failed"
    fi
}

main $@
