#!/bin/bash

function info() {
    echo -ne "\e[34m[DOTFILES]\e[0m $@"
}

function check_for_stow() {
    info "checking for stow..."
    if stow --help > /dev/null 2>&1; then
        echo -e "\e[32mFOUND\e[0m"
        return 0
    else
        echo -e "\e[31mNOT FOUND\e[0m"
        if apt-get --help > /dev/null 2>&1; then
            info "trying to install stow..."
            if sudo apt-get install stow; then
                echo -e "\e[32mINSTALLED\e[0m"
                return 0
            else
                echo -e "\e[31mFAILED\e[0m"
                return 1
            fi
        else
            info "stow not found, please install it and run this script again"
            return 1
        fi
    fi
}

function install_dotfiles() {
    check_for_stow || return 1
    info "running stow:\n"
    if stow --verbose --restow --target=$HOME --ignore=README.md --ignore=install.sh .; then
        info "dotfiles succesfully installed\n"
        return 0
    else
        info "dotfiles installation failed\n"
        return 1
    fi
}

function main() {
    install_dotfiles || return 1
    return 1
}

if main "$@"; then
    result=0
else
    result=1
fi

unset -f info
unset -f check_for_stow
unset -f install_dotfiles
unset -f main

exit $result
