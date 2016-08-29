#!/usr/bin/env bash
cd $(dirname $0)
DRY=false
DOTFILES_ROOT=$(pwd -P)

DOTFILES=(
    .Xresources                     # Set up urxvt with a solarized theme and the inconsolate font.
    .bash_aliases                   # My aliases.
    .bashrc                         # Set up my bash enviroment.
    .bin                            # To place small scripts.
    .config/dunst                   # Dunst config (notification daemon).
    .config/user-dirs.dirs          # I like small initial letters in my $HOME.
    .gdbinit                        # Use intel syntax in gdb disassembly.
    .i3                             # Contains the i3 config file.
    .i3status.conf                  # Configuration for i3 status bar.
    .vim                            # The holy vim folder.
    .vimrc                          # The even holier vim config file.
)

usage() {
    echo "Usage: $(basename $0) [OPTION ...]"
    echo
    echo "Options:"
    echo "  -d, --dry               run dry (no actual file system changes)"
    echo "  -h, --help              show this info"
    echo "  --all                   do everything"
    echo "  --dots                  install dotfiles"
    echo "  --vim                   setup vim"
    echo "  --term                  setup terminal emulator"
    echo "  --i3                    setup i3 window manager"
    echo "  --go                    setup Go 1.7"
}

main() {
    local dots=false
    local vim=false
    local term=false
    local i3=false
    local go=false

    while [[ $# > 0 ]]; do
        case $1 in
            -d|--dry)
                DRY=true
                ;;
            --dots)
                dots=true
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
            --go)
                go=true
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
    $go && setup_go

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

        if [[ -L $target ]]; then
            info "UNLINK: $target"
            $DRY || rm $target
        elif [[ -e $target ]]; then
            info "BACKUP: $target -> ${target}.bak"
            $DRY || mv $target ${target}.bak
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

    info "pulling latest vim source from https://github.com/vim/vim.git"
    if [[ ! -d $DOTFILES_ROOT/vim ]]; then
        git clone https://github.com/vim/vim.git $DOTFILES_ROOT/vim
        cd $DOTFILES_ROOT/vim
    else
        cd $DOTFILES_ROOT/vim
        git pull > /dev/null
    fi

    info "configuring vim"
    ./configure --enable-pythoninterp > /dev/null
    if [[ $? != 0 ]]; then
        info "configuration of vim failed!"
        exit 1
    fi

    info "compiling vim"
    make -j$(nproc) >/dev/null
    if [[ $? != 0 ]]; then
        info "compilation of vim failed!"
        exit 1
    fi

    info "installing vim"
    sudo make install > /dev/null
    if [[ $? != 0 ]]; then
        info "installation of vim failed!"
        exit 1
    fi

    info "vim installed to $(which vim)"
    cd $DOTFILES_ROOT

    info "setting up vim-plug"
    if [[ ! -f $DOTFILES_ROOT/.vim/autoload/plug.vim ]]; then
        curl -fLo $DOTFILES_ROOT/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi
    vim +PlugInstall! +qall

    info "vim installed and ready to roll!"
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

setup_go() {
    info "--- $FUNCNAME ---"

    which go > /dev/null
    if [[ $? != 0 ]]; then
        info "installing go debian package for bootstrapping"
        sudo apt-get install golang-go
    fi

    info "pulling latest go source from https://go.googlesource.com/go"
    if [[ -d $DOTFILES_ROOT/go ]]; then
        cd $DOTFILES_ROOT/go
        git checkout go1.7
    else
        git clone https://go.googlesource.com/go $DOTFILES_ROOT/go
        cd $DOTFILES_ROOT/go
        git checkout go1.7
    fi

    info "compiling go"
    cd $DOTFILES_ROOT/go/src
    GOROOT_BOOTSTRAP=/usr/local/go ./all.bash

    info "removing go from debian package"
    sudo apt-get remove golang-go
}

main $@
