# ~/.bashrc

case $- in
    *i*) ;;
      *) return ;;
esac

stty -ixon

shopt -s checkwinsize
shopt -s histappend

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

export EDITOR=vim
export VISUAL=vim
export WINEARCH=win32
export PS1='\e[0;31m\u\e[0m@\h \w\n\$ '

[[ -x /usr/bin/dircolors ]] && eval "$(dircolors -b)"
[[ -x /usr/bin/lesspipe ]] && eval "$(lesspipe)"
[[ -f /etc/bash_completion ]] && . /etc/bash_completion
[[ -f $HOME/.bash_aliases ]] && . $HOME/.bash_aliases

if [[ -f /etc/bash_completion.d/git-prompt ]]; then
    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWUPSTREAM="auto"
    . /etc/bash_completion.d/git-prompt
    PS1='\e[0;31m\u\e[0m@\h \w$(__git_ps1 " [%s]")\n\$ '
fi

if [[ -d "$HOME/.config/base16-shell" ]]; then
    BASE16_SHELL=$HOME/.config/base16-shell/
    [ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
fi

[[ -d $HOME/bin ]] && PATH=$HOME/bin:$PATH
