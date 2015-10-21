if [ -n "$INSIDE_EMACS" ]; then
	print -P "\033AnSiTu %n"
	print -P "\033AnSiTc %d"
	export TERM=xterm-256color
else
	export TERM=screen-256color
fi

alias setup-zsh="git clone --depth 1 https://github.com/robbyrussell/oh-my-zsh ~/.oh-my-zsh"

ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
ZSH_CUSTOM=$HOME/.zsh
DISABLE_AUTO_UPDATE="true"
DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="true"
plugins=(vi-mode gnu-utils zsh-syntax-highlighting history-substring-search vagrant zaw docker)
source $ZSH/oh-my-zsh.sh

unsetopt correct_all
unsetopt correct

setopt NOCLOBBER

export EDITOR="vim"

export HISTIGNORE="&:ls:[bf]g:cd:.."
export HISTSIZE=25000
export HISTFILE=~/.zsh_history
export SAVEHIST=10000
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY

# Say how long a command took, if it took more than 30 seconds
export REPORTTIME=30

export VIDIR_EDITOR_ARGS='-c :set nolist | :set ft=vidir-ls'

# tmuxp
export DISABLE_AUTO_TITLE='true'

bindkey '^R' zaw-history
zstyle ':filter-select' max-lines 5

bindkey '\e[A' history-substring-search-up
bindkey '\e[B' history-substring-search-down

export ANDROID_HOME=$HOME/.android-sdk-linux


pathes=(
$HOME/.bin
$HOME/.cabal/bin
$ANDROID_HOME/tools
$ANDROID_HOME/platform-tools
$HOME/.kotlinc/bin
$HOME/.gradle/bin
$HOME/.cask/bin
)

for p in $pathes; do
	if [ -d $p ]; then
		export PATH=$p:$PATH
	fi
done

if [ -d $HOME/.rbenv/bin ]; then
	export PATH=$HOME/.rbenv/bin:$PATH
	if [[ -x $(which rbenv) ]]; then
		eval "$(rbenv init -)"
	fi
fi

if [ -d $HOME/.pyenv ]; then
	export PYENV_ROOT="$HOME/.pyenv"
	export PATH="$PYENV_ROOT/bin:$PATH"
	eval "$(pyenv init -)"
fi

if [ -z "$NVM_SOURCED" ]; then
	# export NVM_SOURCED=1
	if [ -d $HOME/.nvm ]; then
		source $HOME/.nvm/nvm.sh
	fi
fi

if [ -f $HOME/.gvm/scripts/gvm ]; then
    source $HOME/.gvm/scripts/gvm
fi

if [ -f $HOME/.ppa ]; then
    uname -a | grep -i ubuntu > /dev/null && source $HOME/.ppa
fi

export ELM_HOME=${NODE_PATH//:/}/elm/share

source $HOME/.zsh-alias

eval `dircolors ~/.dir_colors`

# local settings
if [ -f $HOME/.zshrc-local ]; then
	source $HOME/.zshrc-local
fi

export GOPATH=$GOPATH:$HOME/.projects

# OPAM configuration
. /home/zf/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
