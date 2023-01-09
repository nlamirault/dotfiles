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

. "${HOME}/.config/sketchybar/env.sh"

update() {
    ICON="${ICON_CALENDAR}"
    LABEL=$(date '+%a %-d %b')
    sketchybar --set "${NAME}" icon="${ICON}" label="${LABEL}"
}

add_hover() {
    sketchybar --animate linear 10 --set "${NAME}" background.border_color="${BAR_ACQUA}"
}

remove_hover() {
    sketchybar --animate linear 10 --set "${NAME}" background.border_color="${BAR_BACKGROUND}"
}

mouse_clicked() {
    open -a calendar
}

case "${SENDER}" in
  "mouse.clicked")
    mouse_clicked
    ;;
  "mouse.entered")
    add_hover
    ;;
  "mouse.exited")
    remove_hover
    ;;
  *)
    update
    ;;
esac
