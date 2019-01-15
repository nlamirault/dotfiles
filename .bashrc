# Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# set -e
# set -x

if [ -d ~/.bashrc.d ]; then
    for file in $(/bin/ls ~/.bashrc.d/*.bashrc); do
        . $file;
    done
fi

if [ -d ~/.shrc.d ]; then
    for file in $(/bin/ls ~/.shrc.d/*.shrc); do
        . $file;
    done
fi

[ -f ~/.local.bashrc ] && . ~/.local.bashrc

export COLUMNS=250

APPS=$HOME/Applications

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

export TERM=xterm-256color
# export GDK_NATIVE_WINDOWS=1
