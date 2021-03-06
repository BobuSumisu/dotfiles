# ~/.bashrc

case $- in
    *i*) ;;
      *) return;;
esac

stty -ixon

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend
shopt -s checkwinsize

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

alias vim='nvim'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ll='ls -Alh'

export EDITOR=vim
export GPG_TTY=$(tty)
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
export GOPATH=$HOME/projects/go

export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

scripts=(
    "/usr/share/bash-completion/bash_completion"
    "/etc/bash_completion"
    "$HOME/.bash_aliases"
    "$HOME/.bashrc_local"
    "$HOME/.nvm/bash_completion"
    "$HOME/.local/bin/tmuxinator.bash"
    "$HOME/.fzf.bash"
)
for script in "${scripts[@]}"; do [[ -f "$script" ]] && source "$script"; done
unset scripts

folders=(
    "/usr/local/go/bin"
    "/opt/node/node-v13.9.0-linux-x64/bin"
    "/opt/fleet"
    "$HOME/.cargo/bin"
    "$HOME/projects/go/bin"
    "$HOME/.local/bin"
    "/snap/bin"
)
for folder in "${folders[@]}"; do [[ -d "$folder" ]] && export PATH="$folder:$PATH"; done
unset folders

if hash fdfind 2>/dev/null; then
    export FZF_DEFAULT_COMMAND='fdfind --type f'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

md() {
    pandoc -s -f markdown -t man "$1" | man -l -
}
