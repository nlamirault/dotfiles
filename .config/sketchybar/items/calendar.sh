#!/bin/env sh

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

. "${HOME}/.config/sketchybar/env.sh"

sketchybar \
    --add item     calendar right                                 \
    --set calendar icon=cal                                       \
                   icon.font="$FONT:Black:12.0"                   \
                   icon.padding_right=0                           \
                   label.width=45                                 \
                   label.align=right                              \
                   padding_left=15                                \
                   update_freq=30                                 \
                   script="${SKETCHYBAR_PLUGIN_DIR}/calendar.sh"  \
                   click_script="${SKETCHYBAR_PLUGIN_DIR}/zen.sh" \
    --subscribe    calendar system_woke
