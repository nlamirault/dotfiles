# Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#     http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

PATH=/usr/local/bin:/usr/bin:/bin:/sbin:/usr/bin/X11:/usr/sbin:/usr/lib/postgresql/bin/:$HOME/bin:/usr/games/:/usr/lib/openoffice/program/
export PATH

EDITOR=/usr/bin/neovim
export EDITOR

export COLUMNS=250

APPS=$HOME/Apps

# Emacs lisp
export PATH="$HOME/.cask/bin:$PATH"
export PATH="$HOME/.evm/bin:$PATH"

# Golang
export GOROOT=$HOME/Apps/go
export GOPATH=$HOME/Apps/golang
export PATH=$PATH:$GOPATH/bin:$GOROOT/bin

# Rust
export RUST_SRC_PATH=$HOME/Apps/rust/src
export PATH=$PATH:$RUST_SRC_PATH/usr/local/bin
export PATH=$PATH:$HOME/.cargo/bin/
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:$RUST_SRC_PATH/usr/local/lib

# Java
export JAVA_HOME=$APPS/jre1.7.0_67
export PATH=$PATH:$JAVA_HOME/bin

export MAVEN_1_HOME=$APPS/maven-1.1
export MAVEN_2_HOME=$APPS/apache-maven-2.2.1
export MAVEN_3_HOME=$APPS/apache-maven-3.0.3
export PATH=$PATH:$MAVEN_1_HOME/bin:$MAVEN_3_HOME/bin

export ANT_HOME=$APPS/apache-ant-1.8.2
export PATH=$PATH:$ANT_HOME/bin

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000
export HISTTIMEFORMAT="%h/%d - %H:%M:%S "

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# afficher l'etat du git
function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ [\1$(parse_git_dirty)]/"
}
function display_profile {
	[ -n "${PROFILE:+x}" ] && echo "${PROFILE}";
}


if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

PS1='\[\033[01;33m\][\h]\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[00;32m\]$(parse_git_branch)\[\033[00m\]\[\033[01;35m\]$(display_profile)\[\033[00m\]$ '

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

PERSO_BASH="${HOME}/etc/Perso/bash.d"
if [ -d "$PERSO_BASH" ]; then
    for file in $(ls ${PERSO_BASH}); do
        echo ${file}
        rc=${PERSO_BASH}/${file}
        if [ -f "${rc}" ]; then
            . $rc
        else
            echo "not found ${rc}"
        fi
    done
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

export TERM=xterm-256color
export GDK_NATIVE_WINDOWS=1
