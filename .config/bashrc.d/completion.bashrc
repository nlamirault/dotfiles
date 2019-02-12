#!/usr/bin/env bash

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

# shellcheck source=/dev/null
[ -r /usr/share/bash-completion/bash_completion ] \
    && . /usr/share/bash-completion/bash_completion

if [ -d /etc/bash_completion.d ]; then
    for file in $(/bin/ls /etc/bash_completion.d/*); do
        # shellcheck source=/dev/null
        . "$file";
    done
fi

# shellcheck source=/dev/null
[ -r ~/.fzf.bash ] && . ~/.fzf.bash

# shellcheck source=/dev/null
[ -r /usr/share/bash-completion/completions/git ] && \
    . /usr/share/bash-completion/completions/git
