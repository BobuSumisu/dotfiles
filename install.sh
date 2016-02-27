#!/usr/bin/env bash

cd $(dirname $0)
ROOT=$(pwd -P)
DEBUG=true
BACKUP_FOLDER=$ROOT/backup-$(date "+%Y-%m-%d")

main() {
    link_files

    if [[ -d $BACKUP_FOLDER ]]; then 
        tar -cvzf ${BACKUP_FOLDER}.tar.gz ${BACKUP_FOLDER} > /dev/null 2>&1
        rm -rf $BACKUP_FOLDER
    fi
}

debug() {
    if [[ $DEBUG == true ]]; then
        echo "$1"
    fi
}

link_files() {
    find_dotfiles | while read dotfile; do
        local src=$(realpath -e $dotfile)
        local dst=$HOME/$(basename $src)
        link_file $dst $src
    done
}

link_file() {
    local dst=$1
    local src=$2

    if [[ -e $dst ]]; then
        if [[ $(realpath -e $dst) == $src ]]; then
            debug "UNLINK: $dst"
            rm $dst
        else
            backup $dst
        fi
    fi

    debug "LINK:     $src --> $dst"
    ln -s $src $dst
}

backup() {
    local src=$1
    local dst=$BACKUP_FOLDER/$(basename $1)

    if [[ ! -d $BACKUP_FOLDER ]]; then
        debug "MKDIR:    $BACKUP_FOLDER"
        mkdir $BACKUP_FOLDER
    fi

    debug "BACKUP:   $src --> $dst"
    mv $src $dst
}

find_dotfiles() {
    find . -maxdepth 1 \
        -not -name "\." \
        -not -name "backup*" \
        -not -name "install.sh" \
        -not -name "install_old.sh" \
        -not -name "README.md" \
        -not -name "\.git*" 
}

main $@
