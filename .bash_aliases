# ~/.bash_aliases
# vim: set ft=sh:

alias ls='ls --color=always'
alias ll='ls -al'
alias grep='grep --color=always'

alias cd='pushd $PWD > /dev/null; cd'
alias pop='popd > /dev/null'
alias dshow='dirs -v -l'
alias dclear='dirs -c'

alias www="google-chrome"

alias \:w='echo "you are not in vim now..."'
