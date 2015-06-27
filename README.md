## setup

```sh
git clone https://github.com/zweifisch/dotfiles ~/.dotfiles
cd !$
stow core
stow zsh
stow vim
stow emacs
stow dev
stow pentadactyl
stow x
stow urxvt
stow extra
```

ohmyzsh/rbenv...

```
setup-zsh
setup-rbenv
setup-nvm
setup-git
```

github/gmail and mutt...

```
sudo pip install redact
vi redact.yaml
redact redact.yaml
```

## keybindings

xmonad

* prev workspace `mod4-H`
* next workspace `mod4-L`
* toggle touchpad `mod4-t`

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
* open file in project `\F`
* open file in current dir `\f`

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

## urxvt

* [extensions](https://github.com/muennich/urxvt-perls)

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

* [git-extra](https://github.com/visionmedia/git-extras)

```sh
setup-git
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
* `output-dual` connecting to external monitor
* [nmcli-dmenu](https://github.com/firecat53/nmcli-dmenu)
* [pidcat](https://github.com/JakeWharton/pidcat)
