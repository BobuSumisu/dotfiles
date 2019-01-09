#!/bin/bash
cd "$(dirname ${BASH_SOURCE[0]})"

if [[ $(dpkg -l stow 1>/dev/null) = 1 ]]; then
    sudo apt install stow
fi

stow --verbose --restow --target=$HOME --ignore README.md --ignore tags --ignore install.sh .
