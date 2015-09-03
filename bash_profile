#!/bin/bash

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Load in bash custom aliases, prompt, functions, and private.  The
# bash_private file is for storing user specific environmental variables.

if [ -f $HOME/.dotfiles/private ]; then
  [ -r "$file" ] && source "$file"
fi

# tab completions for sudo
complete -cf sudo

# Bash tab completions
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

if [ -f /etc/git-completion ]; then
    . /etc/git-completion
fi

if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
    . /opt/local/etc/profile.d/bash_completion.sh
fi

if [ -f /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completion
fi

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Append to the Bash history file, rather than overwriting it. Keep your
# terminal history persistent across multiple windows/tabs.
shopt -s histappend

# tab-completion of hostnames after @
shopt -s hostcomplete

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

if [ `uname` == "Darwin" ] && [ -f $HOME/.dotfiles/osx ]; then
    . $HOME/.dotfiles/osx
fi

# =======
# colour
# =======

LS_COLORS='';

# directory colors
LS_COLORS=$LS_COLORS:'di=01;34'

# writable file colors
LS_COLORS=$LS_COLORS:'ow=01;34'

# symlink colors
LS_COLORS=$LS_COLORS:'ln=01;32'

# archive colors
LS_COLORS=$LS_COLORS:'*.tar=1;31'
LS_COLORS=$LS_COLORS:'*.tgz=1;31'
LS_COLORS=$LS_COLORS:'*.gz=1;31'
LS_COLORS=$LS_COLORS:'*.zip=1;31'
LS_COLORS=$LS_COLORS:'*.sit=1;31'
LS_COLORS=$LS_COLORS:'*.lha=1;31'
LS_COLORS=$LS_COLORS:'*.lzh=1;31'
LS_COLORS=$LS_COLORS:'*.arj=1;31'
LS_COLORS=$LS_COLORS:'*.bz2=1;31'
LS_COLORS=$LS_COLORS:'*.7z=1;31'
LS_COLORS=$LS_COLORS:'*.Z=1;31'
LS_COLORS=$LS_COLORS:'*.rar=1;31'

# backup colors
LS_COLORS=$LS_COLORS:'*.swp=1;30'
LS_COLORS=$LS_COLORS:'*.bak=1;30'
LS_COLORS=$LS_COLORS:'*~=1;30'

# python colors
LS_COLORS=$LS_COLORS:'*.py=01;33'
LS_COLORS=$LS_COLORS:'*.pyc=1;37'
LS_COLORS=$LS_COLORS:'*__init__.py=1;36'

# makefile color
LS_COLORS=$LS_COLORS:'*Makefile=4;1;33'

# readme color
LS_COLORS=$LS_COLORS:'*README=4;1;33'

# install color
LS_COLORS=$LS_COLORS:'*INSTALL=4;1;33'

export LS_COLORS

export CLICOLOR=1
export TERM=xterm-256color
# don't generate csv files.
export PYTHONDONTWRITEBYTECODE=1
export WORKON_HOME=$HOME/.virtualenvs
export PIP_RESPECT_VIRTUALENV=true
export PIP_VIRTUALENV_BASE=$WORKON_HOME
export VIRTUALENVWRAPPER_PYTHON=`which python`
export VIRTUALENV_DISTRIBUTE=1
export PYTHONDONTWRITEBYTECODE=True

# no duplicate entries
export HISTCONTROL=ignoredups:erasedups
# save a lot of history.
export HISTSIZE=100000
export HISTFILESIZE=100000
# After each command, save and reload history
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
# Don’t clear the screen after quitting a manual page
export MANPAGER="less -X"
export GREP_COLOR='1;32' # Color value set to green
export PATH="/opt/local/bin:/opt/local/sbin:/Users/nficano/Repositories/rewind:/opt/local/libexec/gnubin/:$PATH"

# ========
# aliases
# ========

alias pcat='pygmentize -O style=native -g'

# navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~"
alias -- -="cd -"

# permissions
alias 640='chmod 640'  # -rw-   r--    ---
alias 644='chmod 644'  # -rw-   r--    r--
alias 755='chmod 755'  # -rwx   r-x    r-x
alias 775='chmod 775'  # -rwx   rwx    r-x

# places
alias d="cd ~/Desktop"
alias dl="cd ~/Downloads"
alias p="cd ~/Projects"
alias r="cd ~/Repositories"
alias log="cd /var/log"

# misc
alias c="clear"
alias dnsflush="dscacheutil -flushcache"
alias e="exit"
alias g="git"
alias h="history"
alias l="ls"
alias la="ls -a"
alias lk='ls -lSr'
alias ll="ls --human-readable --almost-all -l"
alias lm='ls -al |more'
alias lo='ls -l | sed -e 's/--x/1/g' -e 's/-w-/2/g' -e 's/-wx/3/g' -e 's/r--/4/g' -e 's/r-x/5/g' -e 's/rw-/6/g' -e 's/rwx/7/g' -e 's/---/0/g''
alias ls="ls --color=auto --group-directories-first -X --classify -G"
alias lx="ls -lXB"
alias manpdf="man -t *command* | open -f -a Preview"
alias o="open ./"
alias portupdate="sudo port -v upgrade outdated"
alias reload="source ~/.bashrc"
alias sl="ls"
alias sudo="sudo "
alias tl='sudo tail -f $1'
alias tree='find . -type d | sed -e "s/[^-][^\/]*\//  |/g;s/|\([^ ]\)/|-\1/"'

# python
alias vmk='mkvirtualenv'
alias vrm='rmvirtualenv'

# grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# house cleaning
TIDY_FORMAT="-type f -ls -delete"
alias tidyosx="find . \( -name  \*.DS_Store -o -name \*.AppleDouble -o -name \*.LSOverride \) $TIDY_FORMAT"
alias tidywin="find . \( -name Thumbs.db -o -name ehthumbs.db -o -name Desktop.ini \) $TIDY_FORMAT"
alias tidypy="find . \( -name \*.pyc -o -name \*.pyo \) $TIDY_FORMAT"
alias tidyplaylist="find . \( -name \*.m3u -o -name \*.pla -o -name \*.plc -o -name \.*pls \) $TIDY_FORMAT"

# networking
alias sshcp='ssh-copy-id -i ~/id_rsa.pub $1'
alias openports="sudo lsof -Pan -i tcp -i udp | grep -i 'listen'"
alias rsync="rsync -v -P"
alias arpscan="sudo arp -an"

alias nudp="sudo nmap -sS -sU -T4 -A -v -PE -PS22,25,80 -PA21,23,80,3389 "
alias ntcp="sudo nmap -p 1-65535 -T4 -A -v -PE -PS22,25,80 -PA21,23,80,3389 "
alias nping="nmap -sP -PE -PA21,23,80,3389 "
alias nquick="sudo nmap -sV -T4 -O -F --version-light "
alias ntracert="sudo nmap -sP -PE -PS22,25,80 -PA21,23,80,3389 -PU -PO --traceroute "

alias ip="dig +short myip.opendns.com @resolver1.opendns.com"

# mercurial
alias hM="hg commit -m 'Merged'"
alias hpu="hg pull -u"
alias hadd="hg add ."
alias hdiff="hg diff"
alias hl="hg log --no-merges -r: --stat"
alias hm="hg merge"
alias ho="hg out"
alias hs="hg status"
alias hundo="hg revert -C --all"
alias hdiscard="hg update -C -r ."

# vagrant
alias v='vagrant'
alias vs='vagrant suspend'
alias vp='vagrant provision'
alias vu='vagrant up'
alias vunp='vagrant up --no-provision'
alias vh='vagrant halt'
alias vr='vagrant reload'
alias vss='vagrant ssh'

# git
GIT_FORMAT="'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"
alias ga='git add'
alias gb='git branch'
alias gc='git checkout'
alias gcl='git clone'
alias gd='git diff'
alias gdc='git diff --cached'
alias gl="git log --stat --abbrev-commit --pretty=format:$GIT_FORMAT"
alias gm='git commit -m'
alias gma='git commit -am'
alias gp='git push'
alias gpu='git pull'
alias gra='git remote add'
alias greset="git reset --hard origin/master"
alias grr='git remote rm'
alias gs='git status'
alias gt="git log --graph --pretty=format:$GIT_FORMAT --abbrev-commit --date=relative --branches"
alias glast="git reset --soft HEAD^"
alias codereview='git diff $(git rev-list -n1 --before="1 day ago" master) --color'

# ==========
# functions
# ==========

function psgrep () {
  ps aux | grep "$1" | grep -v "grep"
}

# Create a new directory and enter it.
function md() {
    mkdir -p "$@" && cd "$@"
}

function httpdump() {
    sudo tcpdump -nl -w - -i "$@" -c 500 port 80|strings
}

function psapp() {
    ps -ax | grep -i $1 | grep -i -v  "grep.-i.$1" | awk '{print $1}'
}

function killapp() {
    sudo kill $(ps-app $1)
}

function addtopath
{
    directory=`echo $1 | sed 's#/$##'`  # remove trailing slash
    where=$2

    if [ ! -d $directory ]; then
        return 1
    fi

    newpath=`echo $PATH | tr ':' '\n' | \
             grep -v "^$directory\$" | \
             xargs | tr ' ' ':'`


    if [ $where = "beg" ]; then    # Prefix to $PATH
        export PATH=$directory:$newpath
    elif [ $where = "end" ]; then  # Append to $PATH
        export PATH=$newpath:$directory
    else
        return 1
    fi

    return 0
}

function path_append  {
    addtopath $1 end; return $?;
}

function path_prepend {
    addtopath $1 beg; return $?;
}

function up {
  local d=""
  limit=$1
  for ((i=1 ; i <= limit ; i++))
    do
      d=$d/..
    done
  d=$(echo $d | sed 's/^\///')
  if [ -z "$d" ]; then
    d=..
  fi
  cd $d
}

function vpause () {
    VBoxManage list vms | grep "$1" | cut -d' ' -f1 | tr -d '"\n ' | xargs -0 -I BOX VBoxManage controlvm BOX pause
}

function vresume () {
    VBoxManage list vms | grep "$1" | cut -d' ' -f1 | tr -d '"\n ' | xargs -0 -I BOX VBoxManage controlvm BOX resume
}

function vrunning () {
    VBoxManage list runningvms | grep "$1" | cut -d' ' -f1  | tr -d '"\n ' | wc -w | tr -d ' '
}

topten() {
    history | awk '{print $2}' | awk 'BEGIN {FS="|"} {print $1}' | sort | uniq -c | sort -rn | head -10
}

function emptycache() {
    sudo rm -r $HOME/Library/Caches/*
    sudo rm -r /Library/Caches/*
    sudo rm -r /System/Library/Caches/*
}

export PS1="\[\e[0m\]λ\[\e[0m\]\[\e[00;37m\]: \[\e[0m\]\[\e[01;32m\]\w\[\e[0m\]\[\e[00;37m\] > \[\e[0m\]"
