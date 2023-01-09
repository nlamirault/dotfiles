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

airport_data=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I)
AIRPORT=$(echo "${airport_data}" | awk 'NR==1 {print $2}')
LABEL=$(echo "${airport_data}" | grep -o "SSID: .*" | sed 's/^SSID: //')

if [ "${AIRPORT}" = "Off" ]; then
    sketchybar -m --set net icon="${WIFI_OFF}"    \
                            icon.color="${WHITE}" \
                            label.padding_right=2
elif [ -z "$LABEL" ]; then
    sketchybar -m --set net icon="${WIFI_DISCONNECTED}" \
                            icon.color="${WHITE}"       \
                            label.padding_right=2
else
    sketchybar -m --set net icon="${WIFI_CONNECTED}" \
                            icon.color="${GREEN}"    \
                            label.padding_right=4
fi

sketchybar -m --set net label="${LABEL}"
