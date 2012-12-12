ZSH=$HOME/.oh-my-zsh

# Look in ~/.oh-my-zsh/themes/
ZSH_THEME="wedisagree"
ZSH_THEME="gnzh" # exit code
ZSH_THEME="robbyrussell"
ZSH_THEME="sorin" # git branch added modified files exit code 
# ZSH_THEME="jonathan"
ZSH_THEME="powerline"

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

plugins=(vi-mode lein archlinux cap gem gnu-utils npm pip python node rake ruby svn taskwarrior rbenv zsh-syntax-highlighting history-substring-search vagrant supervisor django bundler)
source $ZSH/oh-my-zsh.sh

unsetopt correct_all

export TERM=screen-256color
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

alias vi="vim"
alias e='emacs -nw'
alias j="jobs -l"
alias grep='grep --colour --exclude-dir=".svn"'


alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

alias mkdir='mkdir -p'

alias leiser='amixer -q -c 0 sset Master 5%- unmute'
alias lauter='amixer -q -c 0 sset Master 5%+ unmute'

alias phplint='find . -name "*.php" -exec php -l {} \; | grep -v "No syntax errors detected in"'

alias total-play-time='bc <<< "$(find -name "*.mp3" -print0 | xargs -0 mp3info -p "%S\n" | paste -sd+ | bc) / 60" '

alias vbox='VBoxManage startvm'
alias nb='newsbeuter'
alias pb='podbeuter'

alias svn-url='svn info | grep -i url | cut -d " " -f 2'

alias bc='bc -ql'

alias droid='adb shell busybox'
alias dbox='dropbox'

alias psc='ps xawf -eo pid,user,cgroup,args'

alias cling='cling  -Wc++11-extensions -std=c++11'

alias notebook='ipython notebook --pylab=inline'

alias composer='composer.phar'

# Automatically background processes (no output to terminal etc)
alias 'z=echo $RANDOM > /dev/null; zz'
zz () {
    echo $*
    $* &> "/tmp/z-$1-$RANDOM" &!
}


GRC=`which grc`
if [ -n GRC ]; then
	alias colourify="$GRC -es --colour=auto"
	alias diff='colourify diff'
	alias make='colourify make'
	alias gcc='colourify gcc'
	alias g++='colourify g++'
	alias as='colourify as'
	alias ld='colourify ld'
	alias netstat='colourify netstat'
	alias ping='colourify ping'
	alias traceroute='colourify /usr/sbin/traceroute'
fi

function wow(){
	unrar x $1 && rm -f Readme.png $1
}

uname -a | grep -i ubuntu > /dev/null && alias 'yaourt=sudo apt-get install'

function bright(){
	brightness=`echo "$1 * 0.1" | bc`
	redshiftgui -o -b $brightness
}

function _bright(){
	A=( 5 6 7 8 9 10 )
	_arguments \
		 ":::($A)"
}
compdef _bright bright

alias chrome='z google-chrome --disk-cache-dir="/dev/shm/chrome/" &'
alias chrome-proxy='z google-chrome --disk-cache-dir="/dev/shm/chrome/" --proxy-server="socks5://localhost:7070" &'
alias chrome-dev='z google-chrome --disk-cache-dir="/dev/shm/chrome/" --allow-file-access-from-files  --disable-web-security --remote-debugging-port=9222 &'

alias play2='mplayer -ao alsa:device=hw=2.0'
alias play='mplayer'
alias shot='mplayer -vo jpeg -frames 1 tv://'

function whichweek(){
	week=`date -d "now" +%U`
	echo "$week + 1" | bc
}


function svn-add-all(){
	svn st | grep '^?' | sed 's/^?[ \t]\+//' | xargs -i svn add {}
}

function svn-diff-by-extension(){
	exts='';
	for i in "$@"; do
		if [ -z "$exts" ]; then
			exts="$exts -iname \"*.$i\"";
		else
			exts="$exts -o -iname \"*.$i\"";
		fi
	done;
	svn diff $(eval "find -type f $exts")
}


function start-wicd(){
	sudo wicd
	wicd-cli --wireless -c
}


function quote(){
	curl --silent http://hackersays.com/quote | json c a
}


# A shortcut function that simplifies usage of xclip.
# - Accepts input from either stdin (pipe), or params.
# ------------------------------------------------
cb() {
  local _scs_col="\e[0;32m"; local _wrn_col='\e[1;31m'; local _trn_col='\e[0;33m'
  # Check that xclip is installed.
  if ! type xclip > /dev/null 2>&1; then
    echo -e "$_wrn_col""You must have the 'xclip' program installed.\e[0m"
  # Check user is not root (root doesn't have access to user xorg server)
  elif [[ "$USER" == "root" ]]; then
    echo -e "$_wrn_col""Must be regular user (not root) to copy a file to the clipboard.\e[0m"
  else
    # If no tty, data should be available on stdin
    if ! [[ "$( tty )" == /dev/* ]]; then
      input="$(< /dev/stdin)"
    # Else, fetch input from params
    else
      input="$*"
    fi
    if [ -z "$input" ]; then  # If no input, print usage message.
      echo "Copies a string or the contents of a file to the clipboard."
      echo "Usage: cb <string or file>"
      echo "       echo <string or file> | cb"
    else
      # Copy input to clipboard
      echo -n "$input" | xclip -selection c
      # Truncate text for status
      if [ ${#input} -gt 80 ]; then input="$(echo $input | cut -c1-80)$_trn_col...\e[0m"; fi
      # Print status.
      echo -e "$_scs_col""Copied to clipboard:\e[0m $input"
    fi
  fi
}

function wiki() {
	dig +short txt $1.wp.dg.cx
}

function qq-dict() {
	curl -s "http://dict.qq.com/dict?q=$1"
}

givedef(){
    if [[ $# -ge 2 ]] then
        echo "givedef: too many arguments" >&2
        return 1
    else
        curl "dict://dict.org/d:$1"
    fi
}

function push() {
	git add .
	git ci -m sync
	git push
}

function viwhich() {
	vi `which $1`
}

function min-and-gzipped() {
	uglifyjs $1 | gzip -c | wc -c
}

function f(){
	find . -iname "*$1*"
}

function runc(){
	cc -Wall -g $1.c -o $1.out && ./$1.out
	rm -f $1.out
}

function gitignore(){
	touch .gitignore
	cat  >> .gitignore <<EOF
node_modules
venv
*.pyc
.*swp
EOF
}

if [[ -x $(which ondir) ]]; then
	cd() { builtin cd "$@" && eval "`ondir \"$OLDPWD\" \"$PWD\"`" }
fi


function chpwd(){
	if [ -f venv/bin/activate ] ; then
		source venv/bin/activate
	fi
	if [ -f env.sh ] ; then
		source env.sh # might be dangerous...
	fi
}

function duration(){
	ffprobe "$1" 2>&1 | grep -i duration
}

hourglass(){ trap 'tput cnorm' EXIT INT;local s=$(($SECONDS +$1));(tput civis;while [[ $SECONDS -lt $s ]];do for f in '|' '\' '-' '/';do echo -n "$f" && sleep .2s && echo -n $'\b';done;done;);tput cnorm;}

function uncommited(){
	for gitdir in `find ./ -maxdepth 2 -name .git`; 
	do 
		workdir=${gitdir%/*}; 
		echo; 
		echo $workdir; 
		git --git-dir=$gitdir --work-tree=$workdir status; 
	done
}

export PATH=~/.bin:$PATH

if [ -d $HOME/bin ]; then
	export PATH=~/bin:$PATH
fi

if [ -d /opt/android-sdk/platform-tools ]; then
	export PATH=$PATH:/opt/android-sdk/platform-tools
fi

if [ -d $HOME/.gem/ruby/1.9.1/bin ]; then
	export PATH=$PATH:$HOME/.gem/ruby/1.9.1/bin 
fi

eval `dircolors ~/.dir_colors`

export PATH=~/.rbenv/bin:$PATH
if [[ -x $(which rbenv) ]]; then
	eval "$(rbenv init -)"
fi

# local settings
if [ -f $HOME/.zshrc_local ]; then
	source $HOME/.zshrc_local
fi

if [ -e /usr/bin/systemctl ]; then
	alias start='sudo systemctl start'
	alias stop='sudo systemctl stop'
	alias status='sudo systemctl status'
	alias restart='sudo systemctl restart'
fi

alias getjquery='wget http://code.jquery.com/jquery-1.8.3.min.js'
alias getmustache='wget https://raw.github.com/janl/mustache.js/master/mustache.js'

share(){
	if [ -z "$1" ]; then
		return
	fi
	if [ -f ~/.share-pid ]; then
		if [ kill -0 $(cat ~/.share-pid) > /dev/null 2>&1 ]; then
			echo 'server is running'
		else
			share-start
		fi
	else
		share-start
	fi
	ln -nsf "$(readlink -e "$1")" ~/.share-tmp/
}

share-start(){
	echo 'staring server'
	mkdir ~/.share-tmp
	port=8888
	if [ -n "$1" ]; then
		port=$1
	fi
	cd ~/.share-tmp
	python2 -mSimpleHTTPServer $port &>! ~/.share-log & echo "$!" >! ~/.share-pid
	ls -1
	cd - > /dev/null
}

share-stop(){
	kill $(cat ~/.share-pid) &> /dev/null
	rm -rf ~/.share-tmp
	rm -f ~/.share-pid
}
