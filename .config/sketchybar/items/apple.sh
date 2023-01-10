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

POPUP_OFF="sketchybar --set apple.logo popup.drawing=off"
POPUP_CLICK_SCRIPT="sketchybar --set \$NAME popup.drawing=toggle"

sketchybar \
    --add item           apple.logo left                                           \
    --set apple.logo     icon="${APPLE}"                                           \
                         icon.font="${FONT}:Black:16.0"                            \
                         icon.color="${GREEN}"                                     \
                         padding_right=15                                          \
                         label.drawing=off                                         \
                         click_script="$POPUP_CLICK_SCRIPT"                        \
    --add item           apple.prefs popup.apple.logo                              \
    --set apple.prefs    icon="${PREFERENCES}"                                     \
                         label="Preferences"                                       \
                         click_script="open -a 'System Preferences'; ${POPUP_OFF}" \
    --add item           apple.activity popup.apple.logo                           \
    --set apple.activity icon="${ACTIVITY}"                                        \
                         label="Activity"                                          \
                         click_script="open -a 'Activity Monitor'; ${POPUP_OFF}"   \
    --add item           apple.lock popup.apple.logo                               \
    --set apple.lock     icon="${LOCK}"                                            \
                         label="Lock Screen"                                       \
                         click_script="pmset displaysleepnow; ${POPUP_OFF}"
