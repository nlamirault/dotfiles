#!/usr/bin/env bash

# Copyright (C) 2021 Nicolas Lamirault <nicolas.lamirault@gmail.com>
#
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

# Do not load system
if [ -d /etc/bash_completion.d ]; then
    for file in $(/bin/ls /etc/bash_completion.d/); do
        # shellcheck source=/dev/null
        . /etc/bash_completion.d/"$file";
    done
fi

# shellcheck source=/dev/null
[ -r "${HOME}"/.fzf.bash ] && . "${HOME}"/.fzf.bash


K8S_BINARIES=("kubectl")

for BIN in "${K8S_BINARIES[@]}"; do
  if command -v "${BIN}" > /dev/null 2>&1; then
    # shellcheck source=/dev/null
    . <("${BIN}" completion bash)
  fi
done

if command "gh" > /dev/null 2>&1; then
  eval "$(gh completion -s bash)"
fi

if command "glab" > /dev/null 2>&1; then
  eval "$(glab completion -s bash)"
fi