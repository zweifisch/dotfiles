ZSH=$HOME/.oh-my-zsh

# ZSH_THEME="wedisagree"
# ZSH_THEME="gnzh" # exit code
ZSH_THEME="robbyrussell"
# ZSH_THEME="sorin" # git branch added modified files exit code 
# ZSH_THEME="jonathan"
# ZSH_THEME="powerline"

if [ -n "$INSIDE_EMACS" ]; then
	print -P "\033AnSiTu %n"
	print -P "\033AnSiTc %d"
	ZSH_THEME="robbyrussell"
	export TERM=xterm-256color
else
	export TERM=screen-256color
fi

ZSH_CUSTOM=$HOME/.zsh

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

plugins=(vi-mode gnu-utils zsh-syntax-highlighting history-substring-search vagrant zaw)
source $ZSH/oh-my-zsh.sh

bindkey '\e[A' history-substring-search-up
bindkey '\e[B' history-substring-search-down

# if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
#   source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
# fi

unsetopt correct_all
unsetopt correct

export EDITOR="vim"

export HISTIGNORE="&:ls:[bf]g:exit:reset:clear:cd:cd ..:cd..:mpalyer"
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

setopt NOCLOBBER

export VIDIR_EDITOR_ARGS='-c :set nolist | :set ft=vidir-ls'

export PRO_BASE=$HOME/pg

bindkey '^R' zaw-history
zstyle ':filter-select' max-lines 5

# if [[ -x $(which ondir) ]]; then
# 	cd() { builtin cd "$@" && eval "`ondir \"$OLDPWD\" \"$PWD\"`" }
# fi

pathes=(
$HOME/.bin
$HOME/.cabal/bin
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

eval `dircolors ~/.dir_colors`

export ANSIBLE_HOSTS=hosts

# tmuxp
export DISABLE_AUTO_TITLE='true'

export GOPATH=$HOME/.golang

source $HOME/.zsh-alias
 
uname -a | grep -i ubuntu > /dev/null && source $HOME/.ppa

# local settings
if [ -f $HOME/.zshrc-local ]; then
	source $HOME/.zshrc-local
fi
