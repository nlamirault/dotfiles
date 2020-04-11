#!/bin/bash

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

DEVICE="wlp2s0"

# ROFI="rofi -dmenu -theme ${HOME}/Applications/rofi-scripts/themes/time.rasi"
ROFI="rofi -dmenu"

choice=`find /etc/netctl -maxdepth 1 -type f -printf "%f\n" | sort -u | ${ROFI}`;
if [ -n "$choice" ]; then
    sudo ip link set ${DEVICE} down
    sudo netctl switch-to ${choice}
fi

