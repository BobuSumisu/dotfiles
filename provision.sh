#!/usr/bin/env bash
cd $(dirname $0)
DRY=false
DOTFILES_ROOT=$(pwd -P)
DOTFILES=(
    .bash_aliases
    .bashrc
    .bin
    .config/dunst
    .config/user-dirs.dirs
    .gdbinit
    .i3
    .i3status.conf
    .vim
    .vimrc
    .Xresources
)

usage() {
    echo "Usage: $(basename $0) [OPTION ...]"
    echo
    echo "Options:"
    echo "  -d, --dry               run dry (no actual file system changes)"
    echo "  -h, --help              show this info"
    echo "  --no-dots               do not install dotfiles (default: false)"
    echo "  --vim                   setup vim (default: false)"
    echo "  --term                  setup terminal emulator (default: false)"
    echo "  --i3                    setup i3 window manager (default: false)"
}

main() {
    local dots=true
    local vim=false
    local term=false
    local i3=false

    while [[ $# > 0 ]]; do
        case $1 in
            -d|--dry)
                DRY=true
                ;;
            --no-dots)
                dots=false
                ;;
            --vim)
                vim=true
                ;;
            --term)
                term=true
                ;;
            --i3)
                i3=true
                ;;
            -h|--help)
                usage
                exit 0
                ;;
            *)
                echo "Unknown option: $1"
                exit 1
                ;;
        esac
        shift
    done

    $DRY && info "DRY RUN: not performing any file operations, only showing changes:"

    $dots && {
        uninstall_dotfiles
        install_dotfiles
    }

    $vim && setup_vim
    $term && setup_term
    $i3 && setup_i3

    exit 0
}

info() {
    echo "[INFO] $1"
}

uninstall_dotfiles() {
    info "--- $FUNCNAME ---"

    for f in ${DOTFILES[@]}; do
        local src=$(readlink -e $f)
        local target=$HOME/$f

        if [[ -e $target ]]; then
            if [[ -L $target ]] && [[ $(readlink -e $target) == $src ]]; then
                info "UNLINK: $target"
                $DRY || rm $target
            else
                info "BACKUP: $target -> ${target}.bak"
                $DRY || mv $target ${target}.bak
            fi
        fi
    done
}

install_dotfiles() {
    info "--- $FUNCNAME  ---"

    if [[ ! -d $HOME/.config ]]; then
        info "MKDIR: $HOME/.config"
        $DRY || mkdir $HOME/.config
    fi

    for f in ${DOTFILES[@]}; do
        local src=$(readlink -e $f)
        local target=$HOME/$f

        if [[ -e $target ]]; then
            if [[ $(readlink -e $target) != $src ]]; then
                info "BACKUP: $target -> ${target}.bak"
                $DRY || mv $target ${target}.bak
            fi
        fi

        info "LINK: $src -> $target"
        $DRY || ln -s $src $target
    done
}

setup_vim() {
    info "--- $FUNCNAME ---"

    local vim_packages=( vim-nox build-essential cmake python-dev )

    for p in ${vim_packages[@]}; do
        info "INSTALL: $p"
        $DRY || sudo apt-get install $p
    done

    info "GIT: initializing NeoBundle git submodule"
    $DRY || {
        cd $DOTFILES_ROOT
        git submodule init
        git submodule update
    }

    info "VIM: installing NeoBundle packages"
    $DRY || vim +NeoBundleInstall +qall

    info "YCM: compiling YouCompleteMe (with clang support)"
    $DRY || {
        cd $HOME/.vim/bundle/YouCompleteMe
        ./install.py --clang-completer
        cd $DOTFILES_ROOT
    }
}

setup_term() {
    info "--- $FUNCNAME ---"

    local term_packages=( rxvt-unicode-256color fonts-inconsolata )

    for p in ${term_packages[@]}; do
        info "INSTALL: $p"
        $DRY || sudo apt-get install $p
    done
}

setup_i3() {
    info "--- $FUNCNAME ---"

    local i3_packages=( i3 fonts-inconsolata )

    for p in ${i3_packages[@]}; do
        info "INSTALL: $p"
        $DRY || sudo apt-get install $p
    done
}

main $@
