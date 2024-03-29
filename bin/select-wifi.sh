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

#########################################################
# Netctl

# DEVICE="wlp2s0"

# # ROFI="rofi -dmenu -theme ${HOME}/Applications/rofi-scripts/themes/time.rasi"
# ROFI="rofi -dmenu"

# choice=`find /etc/netctl -maxdepth 1 -type f -printf "%f\n" | sort -u | ${ROFI}`;
# if [ -n "$choice" ]; then
#     sudo ip link set ${DEVICE} down
#     sudo netctl switch-to ${choice}
# fi

#########################################################
# IWD

MENU="rofi -dmenu -l 10 -p"
SECMENU="rofi -dmenu -l 0 -password -p"

# MENU="dmenu -l 10 -p"
# SECMENU="dmenu -l 0 -P -p" # needs the =dmenu-password= patch

if [ $# -gt 0 ]; then
    INTERFACE="$1"
else
    INTERFACE="wlan0"
fi

iwctlstrip() {
    tail -n +5 | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g"
}

# get_interface() {
#     INTERFACE=$(iwctl device list | iwctlstrip | $MENU "Select interface:" | awk '{print $1}')
# }

scan() {
    iwctl station "$INTERFACE" scan && sleep 1
    NETWORKS=$(iwctl station $INTERFACE get-networks | iwctlstrip)
}

get_ssid() {
    PICK=$(printf "%s\n%s\n%s" "$NETWORKS" "disconnect" "scan" | $MENU "network")
    SSID=$(printf "%s" "$PICK" | awk -F" {2,}" '{print $2}' | sed 's/>//' | awk '{$1=$1;print}')

    SEC=$(printf "%s" "$PICK" | awk -F" {2,}" '{print $3}')
    [ "$SEC" = "psk" ] && PSK=1 || PSK=0
    [ "$SEC" = "open" ] && OPEN=1 || OPEN=0

    [ "$PICK" = "disconnect" ] && iwctl station "$INTERFACE" disconnect && notify-send "disconnecting $INTERFACE"
    [ "$PICK" = "scan" ] && scan && get_ssid
    [ "$PICK" = "exit" ] && exit 1
}

get_psk() {
    PSK=$($SECMENU "passphrase" | awk '{print}')
}

connect_open() {
    iwctl station "$INTERFACE" connect "$SSID" || (notify-send -u "critical" "failed to connect to $SSID"; exit 1)
}

connect_psk() {
    get_psk || exit 1
    iwctl station "$INTERFACE" connect "$SSID" -P "$PSK" || (notify-send -u "critical" "failed to connect to $SSID"; exit 1)
}

connect_to_network() {
    scan && get_ssid
    [ "$PSK" = "1" ] && connect_psk && notify-send "connected to $SSID"
    [ "$OPEN" = "1" ] && connect_open && notify-send "connected to $SSID"
}


connect_to_network
