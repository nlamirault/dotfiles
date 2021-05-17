#!/bin/bash

# Copyright (C) 2021 Nicolas Lamirault <nicolas.lamirault@gmail.com>
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

PIHOLE_IP="${2:-192.168.1.228}"
LIVEBOX_IP="192.168.1.1"

function usage {
    echo "Usage: $0 on|off [ pihole IP ]"
}

function dns_pihole_on {
    sed -i "s/nameserver ${LIVEBOX_IP}/nameserver ${PIHOLE_IP}/g" /etc/resolv.conf
}

function dns_pihole_off {
    sed -i "s/nameserver ${PIHOLE_IP}/nameserver ${LIVEBOX_IP}/g" /etc/resolv.conf
}


if [ $# -eq 0 ]; then
    echo "Usage: $0 on|off [ pihole IP ]"
    exit 1
fi

case $1 in
    on)
    dns_pihole_on
    ;;
    off)
    dns_pihole_off
    ;;
    *)
    usage
    ;;
esac
