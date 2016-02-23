#!/bin/bash

# Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#     http:#www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Bash

myos="$(uname)"
case $myos in
   Linux) colorflag="--color" ;;
   FreeBSD|OpenBSD) colorflag="-G";;
   SunOS) colorflag="-G" ;;
   *) ;;
esac

# if ls --color > /dev/null 2>&1; then # GNU `ls`
# 	colorflag="--color"
# else # OS X `ls`
# 	colorflag="-G"
# fi

alias l="ls -lF ${colorflag}"
alias la="ls -laF ${colorflag}"
alias lsd="ls -lF ${colorflag} | grep --color=never '^d'"
alias li="ls -d .* ${colorflag}"

alias clean='find . \( -name ".*~" -o -name "*~" -o -name ".saves*" -o -name ".#*" \) -print -exec /bin/rm {} \;'

alias ls="command ls ${colorflag}"
export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias untar='tar xvf'
alias showmount='mount |column -t'

alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'



# Web

alias httpsnif="sudo ngrep -d 'enp0s25' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i enp0s25 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""
alias showports='netstat -tulanp'

# Misc

alias meteo="curl wttr.in/Bordeaux"
