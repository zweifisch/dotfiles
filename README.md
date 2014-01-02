## keybindings

xmonad

* prev workspace `mod4-H`
* next workspace `mod4-L`

tmux

* prev session `alt-K`
* next session `alt-J`
* prev window `alt-H`
* next window `alt-L`
* left/lower/upper/right panel `alt-h/j/k/l`

vim

* prev buffer `H`
* list buffer `L`
* left/lower/upper/right window `ctrl-h/j/k/l`

pentadactyl

* left/right tab `h/l`
* backward/forward `H/L`

ranger

* `DD` move to ~/.trash

## vim

```
:Bundle install
```

## zsh

```sh
setup-zsh
```

* [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
* [zsh-history-substring-search](https://github.com/zsh-users/zsh-history-substring-search)
* [oh-my-zsh-powerline-theme](https://github.com/jeremyFreeAgent/oh-my-zsh-powerline-theme)
* [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)

## pentadactyl

* [dict](https://github.com/grassofhust/dict.js)
* [buftabs](https://github.com/grassofhust/buftabs)
* :freeze

## tmux

* tmux-powerline
* [tmux-open-url](http://chneukirchen.org/dotfiles/bin/tmux-open-url)
* [tmux-compress](https://github.com/chneukirchen/tools/)

## mutt

* [mutt-solarized-github](https://github.com/altercation/mutt-colors-solarized)

## nvm

* https://github.com/creationix/nvm

```sh
setup-nvm
```

```sh
nvm ls
nvm ls-remote
nvm install v0.11
nvm alias default v0.11
nvm use v0.10
```

## virtualenv

```sh
pip install virtualenv
init-venv
```

## rbenv

```sh
setup-rbenv
```

```sh
rbenv install jruby-<tab>
rbenv rehash

rbenv versions
rbenv global <tab>
```

## git

install [git-extra](https://github.com/visionmedia/git-extras)

```sh
cd /tmp && git clone --depth 1 https://github.com/visionmedia/git-extras.git && cd git-extras && sudo make install
```

## svn

* `svn-url`
* `svn-add-all`
* `svn-diff-by-extension`
* `svn-export-changed <r1> <r2> <url>`

## bitbucket

* `bitbucket-setup`
* `bitbucket-<tab>`

## miscs

* `shot` take snaphot using webcam
* `get-jquery` download jquery, `get-<tab>` for more
* `mem-usage` print memory usage in percent
* `start/stop/restart/status/reload <service>` for ubuntu and arch
* `box` [dropbox uploader](https://github.com/andreafabrizi/Dropbox-Uploader)
* [drip](https://github.com/flatland/drip)
* `inxi -c0 -v7` [inxi](https://inxi.googlecode.com/svn/trunk/inxi)
* `memtop` http://code.google.com/p/memtop/ 1.0.2 
