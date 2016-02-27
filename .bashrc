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

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -x /usr/bin/lesspipe ]; then
    eval "$(lesspipe)"
fi

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi


if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
export PS1="\[\u@$(tput setaf 4)\h$(tput sgr0):\w\]\n\$ "
export PATH=$HOME/projects/unix/scripts:$PATH
