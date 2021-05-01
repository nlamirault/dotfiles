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

# TODO: Currently, this is hardcoded. Ideally, this should be rewritten to be configurable.


export KUBE_PS1_SYMBOL_ENABLE=false
export KUBE_PS1_PREFIX=" "
export KUBE_PS1_SUFFIX=""
# export KUBE_PS1_BG_COLOR=""
# export KUBE_PS1_SYMBOL_COLOR="blue"
# export KUBE_PS1_SEPARATOR=""
export KUBE_PS1_DIVIDER=$' \u2638 '
# export KUBE_PS1_SYMBOL_USE_IMG=true

function ps1_powerline {
  RETCODE=$? # save return code
  NUM_JOBS=$(jobs -rp | wc -l)
  GIT_BRANCH=$(__git_ps1)

  # shellcheck disable=SC2034
  local GREY="\[\e[48;5;240m\]\[\e[38;5;250m\]"
  # shellcheck disable=SC2034
  local GREY_END="\[\e[48;5;2m\]\[\e[38;5;240m\]"

  # shellcheck disable=SC2034
  local GREEN="\[\e[48;5;2m\]\[\e[38;5;255m\]"
  # shellcheck disable=SC2034
  local GREEN_END="\[\e[48;5;27m\]\[\e[38;5;2m\]"

  local ORANGE="\[\e[48;5;208m\]\[\e[38;5;255m\]"
  # shellcheck disable=SC2034
  local ORANGE_END="\[\e[48;5;236m\]\[\e[38;5;208m\]"
  # shellcheck disable=SC2034
  local ORANGE_RET_END="\[\e[48;5;160m\]\[\e[38;5;208m\]" # when next segment is prompt with return code

  local BLUE="\[\e[48;5;27m\]\[\e[38;5;255m\]"
  local BLUE_END="\[\e[48;5;208m\]\[\e[38;5;27m\]"           # when next segment is git
  local BLUE_END_JOBS="\[\e[48;5;93m\]\[\e[38;5;27m\]"       # when next segment is jobs
  local BLUE_END_ALT="\[\e[48;5;236m\]\[\e[38;5;27m\]"       # when next segment is prompt
  local BLUE_END_RET="\[\e[48;5;160m\]\[\e[38;5;27m\]"       # when next segment is prompt with return code

  local JOBS="\[\e[48;5;93m\]\[\e[38;5;255m\] ⏎"
  local JOBS_END="\[\e[48;5;236m\]\[\e[38;5;93m\]"           # when next segment is prompt
  local JOBS_NO_RET_END="\[\e[48;5;208m\]\[\e[38;5;93m\]"    # when next segment is git
  local JOBS_NO_GIT_END="\[\e[48;5;160m\]\[\e[38;5;93m\]"    # when next segment is prompt with return code

  local RET="\[\e[48;5;160m\]\[\e[38;5;255m\]"
  local RET_END="\[\e[0m\]\[\e[38;5;160m\]\[\e[0m\] "

  local -r PROMPT="$(kube_ps1)\[\e[48;5;236m\]\[\e[38;5;255m\]"
  local -r PROMPT_END="\[\e[0m\]\[\e[38;5;236m\]\[\e[0m\] "

  local HOST="\[\e[48;5;236m\]\[\e[38;5;255m\]"
  local HOST_END="\[\e[48;5;27m\]\[\e[38;5;236m\]"

  if [ ! -w "$PWD" ]; then
    # Current directory is not writable
    BLUE_END="\[\e[48;5;160m\]\[\e[38;5;27m\]\[\e[38;5;255m\]  \[\e[48;5;208m\]\[\e[38;5;160m\]"
    BLUE_END_JOBS="\[\e[48;5;160m\]\[\e[38;5;27m\]\[\e[38;5;255m\]  \[\e[48;5;93m\]\[\e[38;5;160m\]"
    BLUE_END_ALT="\[\e[48;5;160m\]\[\e[38;5;27m\]\[\e[38;5;255m\]  \[\e[48;5;236m\]\[\e[38;5;160m\]"
    BLUE_END_RET="\[\e[48;5;160m\]\[\e[38;5;27m\]\[\e[38;5;255m\]  "
  fi

  if [ -z "$GIT_BRANCH" ]; then
    # Is not a git repo
    if [ "$RETCODE" -eq 0 ]; then
      if [ "$NUM_JOBS" -eq 0 ]; then
        # No jobs or ret code
        # PS1="$GREY \t $GREY_END$GREEN @\h $GREEN_END$BLUE \W $BLUE_END_ALT$PROMPT \$ $PROMPT_END"
        PS1="$HOST  \h $HOST_END$BLUE  \W $BLUE_END_ALT$PROMPT  $PROMPT_END"
      else
        # no ret code but jobs
        # PS1="$GREY \t $GREY_END$GREEN @\h $GREEN_END$BLUE \W $BLUE_END_JOBS$JOBS$NUM_JOBS $JOBS_END$PROMPT \$ $PROMPT_END"
        PS1="$HOST  \h $HOST_END$BLUE  \W $BLUE_END_JOBS$JOBS$NUM_JOBS $JOBS_END$PROMPT  $PROMPT_END"
      fi
    else
      if [ "$NUM_JOBS" -eq 0 ]; then
        # No jobs but ret code is there
        # PS1="$GREY \t $GREY_END$GREEN @\h $GREEN_END$BLUE \W $BLUE_END_RET$RET \$ ⚑ $RETCODE $RET_END"
        PS1="$HOST  \h $HOST_END$BLUE  \W $BLUE_END_RET$RET   $RETCODE $RET_END"
      else
        # Both jobs and ret code
        # PS1="$GREY \t $GREY_END$GREEN @\h $GREEN_END$BLUE \W $BLUE_END_JOBS$JOBS$NUM_JOBS $JOBS_NO_GIT_END$RET \$ ⚑ $RETCODE $RET_END"
        PS1="$HOST  \h $GREEN_END$BLUE  \W $BLUE_END_JOBS$JOBS$NUM_JOBS $JOBS_NO_GIT_END$RET   $RETCODE $RET_END"
      fi
    fi
  else
    # Is a git repo
    local -r NUM_MODIFIED=$(git diff --name-only --diff-filter=M | wc -l)
    local -r NUM_STAGED=$(git diff --staged --name-only --diff-filter=AM | wc -l)
    local -r NUM_CONFLICT=$(git diff --name-only --diff-filter=U | wc -l)
    local -r GIT_STATUS="\[\e[48;5;255m\]\[\e[38;5;208m\]\[\e[38;5;27m\]  $NUM_MODIFIED \[\e[38;5;208m\]\[\e[38;5;2m\]  $NUM_STAGED \[\e[38;5;208m\]\[\e[38;5;9m\] ✘ $NUM_CONFLICT "
    if [ "$RETCODE" -eq 0 ]; then
      GIT_STATUS+="\[\e[38;5;255m\]\[\e[48;5;236m\]"
    else
      GIT_STATUS+="\[\e[38;5;255m\]\[\e[48;5;160m\]"
    fi

    if [ "$RETCODE" -eq 0 ]; then
      if [ "$NUM_JOBS" -eq 0 ]; then
        # No jobs or ret code
        # PS1="$GREY \t $GREY_END$GREEN @\h $GREEN_END$BLUE \W $BLUE_END$ORANGE $GIT_BRANCH $GIT_STATUS$PROMPT \$ $PROMPT_END"
        PS1="$HOST  \h $HOST_END$BLUE  \W $BLUE_END$ORANGE $GIT_BRANCH $GIT_STATUS$PROMPT  $PROMPT_END"
      else
        # no ret code but jobs
        # PS1="$GREY \t $GREY_END$GREEN @\h $GREEN_END$BLUE \W $BLUE_END_JOBS$JOBS$NUM_JOBS $JOBS_NO_RET_END$ORANGE $GIT_BRANCH $GIT_STATUS$PROMPT \$ $PROMPT_END"
        PS1="$HOST  \h $HOST_END$BLUE  \W $BLUE_END_JOBS$JOBS$NUM_JOBS $JOBS_NO_RET_END$ORANGE $GIT_BRANCH $GIT_STATUS$PROMPT  $PROMPT_END"
      fi
    else
      if [ "$NUM_JOBS" -eq 0 ]; then
        # No jobs but ret code is there
        # PS1="$GREY \t $GREY_END$GREEN @\h $GREEN_END$BLUE \W $BLUE_END$ORANGE $GIT_BRANCH $GIT_STATUS$RET \$ ⚑ $RETCODE $RET_END"
        PS1="$HOST  \h $HOST_END$BLUE  \W $BLUE_END$ORANGE $GIT_BRANCH $GIT_STATUS$RET   $RETCODE $RET_END"
      else
        # Both jobs and ret code
        # PS1="$GREY \t $GREY_END$GREEN @\h $GREEN_END$BLUE \W $BLUE_END_JOBS$JOBS$NUM_JOBS $JOBS_NO_RET_END$ORANGE $GIT_BRANCH $GIT_STATUS$RET \$ ⚑ $RETCODE $RET_END"
        PS1="$HOST  \h $HOST_END$BLUE  \W $BLUE_END_JOBS$JOBS$NUM_JOBS $JOBS_NO_RET_END$ORANGE $GIT_BRANCH $GIT_STATUS$RET   $RETCODE $RET_END"
      fi
    fi

  fi

}

function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ [\1$(parse_git_dirty)]/"
}

function display_profile {
	[ -n "${PROFILE:+x}" ] && echo "${PROFILE}";
}


function _update_ps1() {
    PS1=$("${HOME}"/bin/powerline-go -error $?)
}


if [  "${TERM}" != "linux" ]; then
  if [ -f "${HOME}/.asdf/shims/starship" ]; then
    eval "$(starship init zsh)"
  elif [ -r "${HOME}/bin/powerline-go" ]; then
    PROMPT_COMMAND="_update_ps1; ${PROMPT_COMMAND}"
  else
    PROMPT_COMMAND="ps1_powerline; ${PROMPT_COMMAND}"
  fi
fi
