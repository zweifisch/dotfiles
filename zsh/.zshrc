# Add deno completions to search path
if [[ ":$FPATH:" != *":/Users/zf/.zsh/completions:"* ]]; then export FPATH="/Users/zf/.zsh/completions:$FPATH"; fi
export TERM=screen-256color

alias setup-zsh="git clone --depth 1 https://github.com/robbyrussell/oh-my-zsh ~/.oh-my-zsh"

ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
ZSH_CUSTOM=$HOME/.zsh
DISABLE_AUTO_UPDATE="true"
DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="true"
plugins=(vi-mode gnu-utils zsh-syntax-highlighting history-substring-search vagrant docker zsh-peco-history conda)
source $ZSH/oh-my-zsh.sh

unsetopt correct_all
unsetopt correct

setopt NOCLOBBER

export EDITOR="vim"

export HISTIGNORE="&:ls:[bf]g:cd:..:mkdir"
export HISTSIZE=500000
export HISTFILE=~/.zsh_history
export SAVEHIST=100000
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY

# Say how long a command took, if it took more than 30 seconds
export REPORTTIME=30

export VIDIR_EDITOR_ARGS='-c :set nolist | :set ft=vidir-ls'

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=7'

# tmuxp
export DISABLE_AUTO_TITLE='true'

bindkey '\e[A' history-substring-search-up
bindkey '\e[B' history-substring-search-down

# export ANDROID_HOME=$HOME/.android-sdk-linux


pathes=(
$HOME/.bin
$HOME/.local/bin
$HOME/.cabal/bin
$ANDROID_HOME/tools
$ANDROID_HOME/platform-tools
$HOME/.kotlinc/bin
$HOME/.gradle/bin
$HOME/.cask/bin
$HOME/.swift/usr/bin
$HOME/Library/Python/3.7/bin
$HOME/.deno/bin
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

export NVM_DIR="$HOME/.nvm"
if [ -f "$NVM_DIR/nvm.sh" ]; then
    source "$NVM_DIR/nvm.sh" # This loads nvm
fi

if [ -f $HOME/.gvm/scripts/gvm ]; then
    source $HOME/.gvm/scripts/gvm
fi

if [ -f $HOME/.ppa ]; then
    uname -a | grep -i ubuntu > /dev/null && source $HOME/.ppa
fi

# OPAM configuration
if [ -f $HOME/.opam/opam-init/init.zsh ]; then
    source $HOME/.opam/opam-init/init.zsh
fi

export ELM_HOME=${NODE_PATH//:/}/elm/share

source $HOME/.zsh-alias
if [ -f $HOME/.zsh-alias-`uname` ]; then
    source $HOME/.zsh-alias-`uname`
fi

eval `dircolors ~/.dir_colors`

# local settings
if [ -f $HOME/.zshrc-local ]; then
	source $HOME/.zshrc-local
fi

if [ -n "$GOPATH" ]; then
    export GOPATH=$GOPATH:$HOME/.projects
else
    export GOPATH=$HOME/.projects
fi

export PATH=$HOME/.projects/bin:$PATH

if [ -d "$HOME/.linuxbrew" ]; then
    export PATH="$HOME/.linuxbrew/bin:$PATH"
    export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
    export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"
fi

if [ -d /usr/lib/jvm/java-1.8.0-openjdk-amd64 ]; then
    JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64
fi

export JAVA_HOME=$(/usr/libexec/java_home)

if [ -d "$HOME/.zaw" ]; then
    source ~/.zaw/zaw.zsh

    bindkey '^R' zaw-history
    bindkey '^X:' zaw

    zstyle ':filter-select' max-lines $(($LINES / 2))
    zstyle ':filter-select' case-insensitive yes
    zstyle ':filter-select' extended-search yes

    zstyle ':filter-select:highlight' selected standout,bold
    zstyle ':filter-select:highlight' matched fg=magenta,underline
    zstyle ':filter-select:highlight' marked fg=blue,standout
    zstyle ':filter-select:highlight' title bold
    zstyle ':filter-select:highlight' error fg=white,bg=red
fi

source <(kubectl completion zsh)

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$HOME/.luarocks/bin:$PATH"

# export ZPLUG_HOME=/usr/local/opt/zplug
# source $ZPLUG_HOME/init.zsh

# zplug "jimeh/zsh-peco-history"

if [ -e /home/zf/.nix-profile/etc/profile.d/nix.sh ]; then . /home/zf/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

export PNPM_HOME="/home/zf/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"

export PATH="/opt/homebrew/bin:$PATH"

[ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"

# Wasmer
# export WASMER_DIR="/Users/zf/.wasmer"
# [ -s "$WASMER_DIR/wasmer.sh" ] && source "$WASMER_DIR/wasmer.sh"
# . "/Users/zf/.wasmedge/env"

export LANG="en_US.UTF-8"

eval "$(direnv hook zsh)"

# bun completions
[ -s "/Users/zf/.bun/_bun" ] && source "/Users/zf/.bun/_bun"

# Bun
export BUN_INSTALL="/Users/zf/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export PATH="$HOME/.poetry/bin:$PATH"
export PATH="/usr/local/opt/gnu-getopt/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
# export PATH="/opt/homebrew/anaconda3/bin:$PATH"  # commented out by conda initialize

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(mise activate zsh)"
# Initialize zsh completions (added by deno install script)
autoload -Uz compinit
compinit