# ~/.bashrc

case $- in
    *i*) ;;
      *) return;;
esac

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend
shopt -s checkwinsize

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ll='ls -Alh'
alias vim=nvim

export EDITOR=vim
export GPG_TTY=$(tty)
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

scripts=(
    "/usr/share/bash-completion/bash_completion"
    "/etc/bash_completion"
    "$HOME/.bash_aliases"
    "$HOME/.bashrc_local"
    "$HOME/.nvm/nvm.sh"
    "$HOME/.nvm/bash_completion"
    "$HOME/.local/bin/tmuxinator.bash"
    "$HOME/.fzf.bash"
)
for script in "${scripts[@]}"; do [[ -f "$script" ]] && source "$script"; done
unset scripts

folders=(
    "/usr/local/go/bin"
    "$HOME/.cargo/bin"
    "$HOME/projects/go/bin"
    "$HOME/bin"
)
for folder in "${folders[@]}"; do [[ -d "$folder" ]] && export PATH="$folder:$PATH"; done
unset folders
