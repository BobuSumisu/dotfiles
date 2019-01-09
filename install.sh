#!/bin/bash
cd "$(dirname ${BASH_SOURCE[0]})"
BASE_DIR=$(pwd)

stow --verbose --restow --target=$HOME --ignore README.md --ignore tags --ignore install.sh .
