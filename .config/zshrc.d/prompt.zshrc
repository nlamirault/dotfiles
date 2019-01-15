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

autoload -U colors && colors

# Prompt by Zsh:
# autoload -U promptinit
# promptinit


# # Allow command substitution in the prompt
# setopt prompt_subst

# # Save git status before each prompt display
# function precmd {
#   $(git status 2> /dev/null >! $HOME/.git-status-for-prompt)
# }

# # Display colored git branch if we are in a git repo
# function git_colored_prompt() {
#   ref=$(git symbolic-ref HEAD 2> /dev/null) || return
#   echo "$(git_color_status)(${ref#refs/heads/}$(git_commits))"
# }

# # Append git commit difference to prompt
# function git_commits() {
#   git_info=$(cat $HOME/.git-status-for-prompt)
#   if [ -n "$(echo $git_info | grep "Your branch is behind")" ]; then
#     difference="-"
#   elif [ -n "$(echo $git_info | grep "Your branch is ahead of")" ]; then
#     difference="+"
#   fi
#   if [ -n $difference ]; then
#     difference+=$(echo $git_info | grep "Your branch is" | sed "s/Your branch is .* by//g" | sed "s/[^0-9]//g")
#     echo $difference
#   fi
# }

# # Change colors depending on git status
# function git_color_status() {
#   git_info=$(cat $HOME/.git-status-for-prompt)
#   if [ -n "$(echo $git_info | grep "Changes not staged")" ]; then
#     echo "%{$fg[red]%}"
#   elif [ -n "$(echo $git_info | grep "Changes to be committed")" ]; then
#     echo "%{$fg[yellow]%}"
#   elif [ -n "$(echo $git_info | grep "Untracked files")" ]; then
#     echo "%{$fg[cyan]%}"
#   else
#     echo "%{$fg[green]%}"
#   fi
# }


# # Custom prompt
# PROMPT='%{$bg[black]%}  %M %{$reset_color%}%{$fg[black]%}%{$reset_color%}%{$bg[blue]%} %{$bg[black]%}  %{$reset_color%}%{$fg[black]%}%{$reset_color%} '

