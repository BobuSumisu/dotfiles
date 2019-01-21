# ~/.bashrc

# Interactive Test {{{

case $- in
    *i*) ;;
      *) return ;;
esac

# }}}

# Options {{{

stty -ixon

shopt -s checkwinsize
shopt -s histappend

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

# }}}

# Environment {{{

export EDITOR=vim
export VISUAL=vim
export WINEARCH=win32
export PS1='\e[0;31m\u\e[0m@\h \w\n\$ '
export GOPATH="$GOPATH:~/go"

# }}}

# Helpers {{{

for f in \
    /usr/bin/dircolors \
    /usr/bin/lesspipe
do
    if [[ -x $f ]]; then
        eval "$($f)"
    fi
done

# }}}

# Scripts {{{

for f in \
    /etc/bash_completion \
    /usr/share/bash-completion/completions/tmuxinator \
    ~/.bash_aliases \
    ~/.fzf.bash \
    ~/.nvm/nvm.sh \
    ~/.gvm/scripts/gvm
do
    if [[ -f $f ]]; then
        source $f
    fi
done

# }}}

# $PATH {{{

for f in \
    /snap/bin \
    ~/.cargo/bin \
    ~/bin \
    ~/.bin \
    ~/.local/bin
do
    if [[ -d $f ]]; then
        PATH="$f:$PATH"
    fi
done

# }}}

# Git Prompt {{{

if [[ -f /etc/bash_completion.d/git-prompt ]]; then
    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWUPSTREAM="auto"
    . /etc/bash_completion.d/git-prompt
    PS1='\e[0;31m\u\e[0m@\h \w$(__git_ps1 " [%s]")\n\$ '
fi

# }}}

# Aliases {{{

alias ls='ls --color=auto'
alias ll='ls -al'
alias grep='grep --color=auto'

# }}}
