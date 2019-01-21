# dotfiles

    My dotfiles brings all the boys to the yard,
    and they're like, it's better than yours.

## Install

```bash
$ stow -v -R -t $HOME --ignore README.md .
$ fc-cache -v
```

## Todo

* Make it work offline
    * Use git subtrees for vim plugins?
    * Include repos as subtrees?
        * [vim 8.1+](https://github.com/vim/vim)
        * [alacritty](https://github.com/jwilm/alacritty) (need internet to pull cargo packages...)
        * [fzf](https://github.com/junegunn/fzf)
