# ~/.bashrc

case $- in
    *i*) ;;
      *) return ;;
esac

shopt -s histappend
shopt -s checkwinsize

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

[[ -x /usr/bin/dircolors ]] && eval "$(dircolors -b)"
[[ -x /usr/bin/lesspipe ]] && eval "$(lesspipe)"
[[ -f /etc/bash_completion ]] && . /etc/bash_completion
[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases
[[ -f ~/.git-completion.bash ]] && . ~/.git-completion.bash
[[ -f ~/.git-prompt.sh ]] && . ~/.git-prompt.sh
[[ -f ~/projects/bash/bash-bookmarks/bash_bookmarks.sh ]] && . ~/projects/bash/bash-bookmarks/bash_bookmarks.sh

# Disable Software Flow Control (avoid CTRL+S / CTRL+Q shit).
stty -ixon

export EDITOR=vim
export VISUAL=vim

export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

export WINEARCH=win32

export GOROOT=~/projects/3rd/go
export GOPATH=~/projects/go

export RUST_SRC_PTH=~/.multirust/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src

export PATH=$PATH:~/.bin:~/.local/bin:$GOPATH/bin:$GOROOT/bin:~/.cargo/bin:/opt/Unity/Editor:~/.cabal/bin
export PATH=$PATH:/home/master/projects/3rd/bazel/output
export PATH=$PATH:/opt/wine-staging/bin
export PATH=$PATH:~/projects/3rd/elixir/bin
export PATH=$PATH:/usr/local/i386elfgcc/bin

export PS1='\u@$(tput setaf 4)\h$(tput sgr0) \w$(__git_ps1 " (%s)")\n\$ '

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[[ -s "/home/master/.gvm/scripts/gvm" ]] && source "/home/master/.gvm/scripts/gvm"

export SSLKEYLOGFILE=/home/master/.ssl.log

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
