#!/bin/bash

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

MODE="1920x1080"

function screen_layout_laptop() {
    xrandr --output HDMI-2 --off --output HDMI-1 --off --output DP-1 --off --output eDP-1 --primary --mode ${MODE} --pos 0x0 --rotate normal --output DP-2 --off
}

function screen_layout_all {
    xrandr --output HDMI-2 --off --output HDMI-1 --off --output DP-1 --off --output eDP-1 --primary --mode ${MODE} --pos 0x1080 --rotate normal --output DP-2 --mode ${MODE} --pos 0x0 --rotate normal
}

choice=$(echo -e "Only laptop\nAll screen" | rofi -dmenu)
echo ${choice}

case ${choice} in
    "Only laptop")
        screen_layout_laptop
        ;;
    "All screen")
        screen_layout_all
        ;;
    *)
        echo "Choice unavailable"
    ;;
esac
