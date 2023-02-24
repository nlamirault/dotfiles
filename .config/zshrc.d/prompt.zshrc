#!/usr/bin/env zsh

# Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
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
#
# SPDX-License-Identifier: Apache-2.0

autoload -U colors && colors

# Prompt by Zsh:
# autoload -U promptinit
# promptinit

# # Allow command substitution in the prompt
setopt prompt_subst

if [  "$TERM" != "linux" ]; then
  # if [ -f "${HOME}/.asdf/shims/starship" ]; then
  #   eval "$(starship init zsh)"
  if [ -f /usr/bin/starship ]; then
    eval "$(starship init zsh)"
  elif [ -f /usr/local/bin/starship ]; then
    eval "$(starship init zsh)"
  elif [ -f /opt/homebrew/bin/starship ]; then
    eval "$(starship init zsh)"
  fi
fi
