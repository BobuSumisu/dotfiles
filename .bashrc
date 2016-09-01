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

export EDITOR=vim
export VISUAL=vim

export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

export WINEARCH=win32

export GOPATH=~/projects/go
export GOROOT=/home/oyvind/projects/bash/dotfiles/go

export PATH=$PATH:~/.bin:~/.local/bin:$GOPATH/bin:$GOROOT/bin

export PS1='\u@$(tput setaf 4)\h$(tput sgr0) \w$(__git_ps1 " (%s)")\n\$ '
<<<<<<< HEAD

=======
>>>>>>> bfce05bdcf318a56fefc911ae94984293478c3f8
