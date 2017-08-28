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

if [ -d ~/.bashrc.d ]; then
    for file in $(/bin/ls ~/.bashrc.d/*.bashrc); do
        . $file;
    done
fi

export COLUMNS=250

APPS=$HOME/Apps

XDG_CACHE_HOME=${HOME}/.cache
XDG_DATA_HOME=${HOME}/.share
XDG_DATA_DIRS=${HOME}/.share

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

export TERM=xterm-256color
# export GDK_NATIVE_WINDOWS=1
export GTK2_RC_FILES=/usr/share/themes/Arc-Dark/gtk-2.0/gtkrc
export GTK_THEME=Arc:dark


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
