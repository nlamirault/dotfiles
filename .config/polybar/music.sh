#!/usr/bin/env sh

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

# player_status=$(playerctl status 2> /dev/null)
# # echo "===> ${player_status}"
# if [[ "${player_status}" == "Playing" ]]; then
#     metadata="$(playerctl metadata artist) - $(playerctl metadata title)"
#     echo "${metadata}"
# fi

ARTIST=$(playerctl metadata xesam:artist | sed 's/\b\(.\)/\u\1/g')
TITLE=$(playerctl metadata xesam:title | sed 's/\b\(.\)/\u\1/g')
echo "$ARTIST - $TITLE"
