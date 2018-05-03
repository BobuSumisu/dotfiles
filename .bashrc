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
export PS1='\u@\h \w\n\$ '

[[ -x /usr/bin/dircolors ]] && eval "$(dircolors -b)"
[[ -x /usr/bin/lesspipe ]] && eval "$(lesspipe)"
[[ -f /etc/bash_completion ]] && . /etc/bash_completion
[[ -f /etc/bash_completion.d/git-prompt ]] && . /etc/bash_completion.d/git-prompt
[[ -f $HOME/.bash_aliases ]] && . $HOME/.bash_aliases

if [[ -d "$HOME/.config/base16-shell" ]]; then
    BASE16_SHELL=$HOME/.config/base16-shell/
    [ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
fi

[[ -d $HOME/bin ]] && PATH=$HOME/bin:$PATH
[[ -d $HOME/node_modules/.bin ]] && PATH=$HOME/node_modules/.bin:$PATH
[[ -s $HOME/.gvm/scripts/gvm ]] && . $HOME/.gvm/scripts/gvm

if [[ -d $HOME/.nvm ]]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
fi

