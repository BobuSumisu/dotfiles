# dotfiles

## Overview

* `.Xresources`: sets a solarized theme for X client applications and set up `urxvt`.

## Requirements

### Applications

Expected to be used with `urxvt`:

    $ sudo apt-get install rxvt-unicode-256color 

### Fonts

Uses fonts [Hack](http://sourcefoundry.org/hack/), [Inconsolata](http://www.levien.com/type/myfonts/inconsolata.html),
or [GNU Unifont](http://unifoundry.com/unifont.html).

    # if Debian unstable is enabled:
    $ sudo apt-get install fonts-hack-ttf

    # else:
    $ wget http://no.archive.ubuntu.com/ubuntu/pool/universe/f/fonts-hack/fonts-hack-ttf_2.019-1_all.deb
    $ sudo dpkg -i fonts-hack-ttf_2.019-1_all.deb


    # other fonts:
    $ sudo apt-get install fonts-inconsolata unifont

## Install
    
    $ make install
