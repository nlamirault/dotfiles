#!/usr/bin/env zsh

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

autoload -U colors && colors

# Prompt by Zsh:
# autoload -U promptinit
# promptinit

# # Allow command substitution in the prompt
setopt prompt_subst

# Replace prompt using Starship
# eval "$(starship init bash)"

POWERLINE_GO_MODULES="user,host,ssh,cwd,perms,git,kube,root,exit"

DIRECTORY_END=""

function kube_prompt() {

  # Get current context
  CONTEXT=$(cat ~/.kube/config | grep "current-context:" | sed "s/current-context: //")
  if [ -n "$CONTEXT" ]; then
      echo "(k8s: ${CONTEXT})"
  fi
}


function git_prompt() {
    GIT_BRANCH=$(__git_ps1)
    if [ -z "$GIT_BRANCH" ]; then
    else
        local NUM_MODIFIED=$(git diff --name-only --diff-filter=M | wc -l)
        local NUM_STAGED=$(git diff --staged --name-only --diff-filter=AM | wc -l)
        local NUM_CONFLICT=$(git diff --name-only --diff-filter=U | wc -l)
        local GIT_STATUS=" %F{27}%K{255}  $NUM_MODIFIED %k%f"
        # local GIT_STATUS="\[\e[48;5;255m\]\[\e[38;5;208m\]\[\e[38;5;27m\]  $NUM_MODIFIED \[\e[38;5;208m\]\[\e[38;5;2m\]  $NUM_STAGED \[\e[38;5;208m\]\[\e[38;5;9m\] ✘ $NUM_CONFLICT "
        ref=$(git symbolic-ref HEAD 2> /dev/null) || return
        DIRECTORY_END="%F{27}%K{208}"
        echo "%F{255}%K{208} (${ref#refs/heads/})"
    fi
}

# # Display colored git branch if we are in a git repo
function git_colored_prompt() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "$(git_color_status) (${ref#refs/heads/}$(git_commits))"
}

# # Append git commit difference to prompt
function git_commits() {
  git_info=$(cat $HOME/.git-status-for-prompt)
  if [ -n "$(echo $git_info | grep "Your branch is behind")" ]; then
    difference="-"
  elif [ -n "$(echo $git_info | grep "Your branch is ahead of")" ]; then
    difference="+"
  fi
  if [ -n $difference ]; then
    difference+=$(echo $git_info | grep "Your branch is" | sed "s/Your branch is .* by//g" | sed "s/[^0-9]//g")
    echo $difference
  fi
}

# # Change colors depending on git status
function git_color_status() {
  git_info=$(cat $HOME/.git-status-for-prompt)
  if [ -n "$(echo $git_info | grep "Changes not staged")" ]; then
    echo "%{$fg[red]%}"
  elif [ -n "$(echo $git_info | grep "Changes to be committed")" ]; then
    echo "%{$fg[yellow]%}"
  elif [ -n "$(echo $git_info | grep "Untracked files")" ]; then
    echo "%{$fg[cyan]%}"
  else
    echo "%{$fg[green]%}"
  fi
}

function powerline_precmd() {
    PS1="$($HOME/bin/powerline-go -error $? -shell zsh -shorten-gke-names -shorten-eks-names -modules ${POWERLINE_GO_MODULES} -truncate-segment-width 5)"
}

function install_powerline_precmd() {
  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

# Custom prompt

if [  "$TERM" != "linux" ]; then
  if [ -f "${HOME}/.asdf/shims/starship" ]; then
    eval "$(starship init bash)"
  elif [ -f "$HOME/bin/powerline-go" ]; then
    install_powerline_precmd
  else
    PROMPT='%F{255}%K{0}  %M %k%f%F{0}%K{27} %F{255}%K{27} %2~ %k%f%F{27}%K{208} $(git_prompt) %k%f%F{208}%K{0}%F{255}%K{0}  %F{0}%K{232} $(kube_prompt) %{$reset_color%} '
  fi
fi
