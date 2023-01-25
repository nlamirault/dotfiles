#!/usr/bin/env bash

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

# UPDOWN=$(ifstat -i "en0" -b 0.1 1 | tail -n1)
# DOWN=$(echo "${UPDOWN}" | awk "{ print \$1 }" | cut -f1 -d ".")
# UP=$(echo "${UPDOWN}" | awk "{ print \$2 }" | cut -f1 -d ".")

# DOWN_FORMAT=""
# if [ "${DOWN}" -gt "999" ]; then
#   DOWN_FORMAT=$(echo "${DOWN}" | awk '{ printf "%.0f Mbps", $1 / 1000}')
# else
#   DOWN_FORMAT=$(echo "${DOWN}" | awk '{ printf "%.0f kbps", $1}')
# fi

# UP_FORMAT=""
# if [ "${UP}" -gt "999" ]; then
#   UP_FORMAT=$(echo "${UP}" | awk '{ printf "%.0f Mbps", $1 / 1000}')
# else
#   UP_FORMAT=$(echo "${UP}" | awk '{ printf "%.0f kbps", $1}')
# fi

# echo "${UP} ${UP}_FORMAT, ${DOWN} ${DOWN}_FORMAT"

# sketchybar -m \
#   --set network_down label="${DOWN_FORMAT}" icon.highlight=$(if [ "${DOWN}" -gt "0" ]; then echo "on"; else echo "off"; fi) \
#   --set network_up label="${UP_FORMAT}" icon.highlight=$(if [ "${UP}" -gt "0" ]; then echo "on"; else echo "off"; fi)

airport_data=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I)
AIRPORT=$(echo "$airport_data" | awk 'NR==1 {print $2}')
LABEL=$(echo "$airport_data" | grep -o "SSID: .*" | sed 's/^SSID: //')
UPDOWN=$(ifstat -i "en0" -b 0.1 1 | tail -n1)
DOWN=$(echo $UPDOWN | awk "{ print \$1 }" | cut -f1 -d ".")
UP=$(echo $UPDOWN | awk "{ print \$2 }" | cut -f1 -d ".")
DOWN_SPEED=$((DOWN/8))
UP_SPEED=$((UP/8))
SPEED=""

if [ $AIRPORT = "Off" ] || [ -z "$LABEL" ]; then
    sketchybar -m --set network icon.drawing=off
elif [ "$UP_SPEED" -gt "$DOWN_SPEED" ]; then
    sketchybar -m --set network icon.drawing=on icon=$UPLOAD
    if [ "$UP_SPEED" -gt "999" ]; then
        SPEED=$(echo $UP_SPEED | awk '{ printf "%.1f MB/s", $1 / 1000}')
    else
        SPEED=$(echo $UP_SPEED | awk '{ printf "%.1f KB/s", $1}')
    fi
else
    sketchybar -m --set network icon.drawing=on icon=$DOWNLOAD
    if [ "$DOWN_SPEED" -gt "999" ]; then
        SPEED=$(echo $DOWN_SPEED | awk '{ printf "%.1f MB/s", $1 / 1000}')
    else
        SPEED=$(echo $DOWN_SPEED | awk '{ printf "%.1f KB/s", $1}')
    fi
fi
sketchybar -m --set network label="$SPEED"
