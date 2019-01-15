# Copyright (C) 2016-2019 Nicolas Lamirault <nicolas.lamirault@gmail.com>

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

if [ -d ~/.config/zshrc.d ]; then
    for file in $(/bin/ls ~/.config/zshrc.d/*.zshrc); do
        . $file;
    done
fi

if [ -d ~/.config/shrc.d ]; then
    for file in $(/bin/ls ~/.config/shrc.d/*.shrc); do
        . $file;
    done
fi

# Load local configuration
[ -f ~/.local.zshrc ] && . ~/.local.zshrc

export COLUMNS=250

APPS=$HOME/Applications