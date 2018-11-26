# ~/.bash_aliases
# vim: set ft=sh:

# The standards.
alias ls='ls --color=always'
alias ll='ls -al'
alias grep='grep --color=auto'

# Jesus.
alias \:w='echo "you are not in vim now..."'

# Some git shortcuts.
alias gita='git add'
alias gitb='git blame'
alias gitc='git clone'
alias gitd='git diff'
alias gite='git merge'
alias gitf='git fetch'
alias gitg='git grep'
alias gith='git show'
alias giti='git init'
alias gitl='git log'
alias gitm='git commit'
alias gitn='git branch'
alias gito='git checkout'
alias gitp='git push'
alias gitr='git rm'
alias gits='git status'
alias gitt='git reset'
alias gitu='git pull'
alias gitv='git mv'

# Apt
alias aptup='sudo apt-get update'
alias aptug='sudo apt-get upgrade'
alias aptuu='sudo apt-get update && sudo apt-get upgrade'
alias aptcs='apt-cache search'
alias aptch='apt-cache show'
alias aptcp='apt-cache showpkg'
alias aptcd='apt-cache depends'

# Golang
alias go-deps='go list -f "{{ join .Deps \"\n\" }}"'
alias go-imps='go list -f "{{ join .Imports \"\n\" }}"'

alias t='todo.sh'
complete -F _todo t
