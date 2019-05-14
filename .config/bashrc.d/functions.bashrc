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
#

function extract(){
  if [ -f "${1}" ] ; then
    case "${1}" in
      *.tar.bz2) tar xjf "${1}" ;;
      *.tar.gz) tar xzf "${1}" ;;
      *.bz2) bunzip2 "${1}" ;;
      *.rar) unrar x "${1}" ;;
      *.gz) gunzip "${1}" ;;
      *.tar) tar xf "${1}" ;;
      *.tbz2) tar xjf "${1}" ;;
      *.tgz) tar xzf "${1}" ;;
      *.zip) unzip "${1}" ;;
      *.Z) uncompress "${1}" ;;
      *.7z) 7z x "${1}" ;;
      *.xz) tar xJf "${1}" ;;
      *) echo -e "Unknown format.\n${1}" ;;
    esac
  else
    echo "Invalid file specified. ${1}" >/dev/stderr
    exit 1
  fi
}

function weather() {
    curl http://wttr.in/"${1:-bordeaux}"
}

function coin() {
    curl http://rate.sx/"${1}"
}

function ip_info() {
    curl ipinfo.io/"${1:-8.8.8.8}"
}

function print_colors() {
  for i in {0..255};
  do
    printf "\x1b[38;5;%smcolour%s\x1b[0m\n" ${i} ${i}
  done
}

function ssh_proxy_socks() {
    ip_addr=$1
    ssh -D 8888 -q -C -N ${ip_addr}
}
