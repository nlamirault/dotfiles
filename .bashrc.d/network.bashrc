#!/usr/bin/env bash

# Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>

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

alias fwlist="sudo /sbin/iptables -L -n -v --line-numbers"
alias fwlistin="sudo /sbin/iptables -L INPUT -n -v --line-numbers"
alias fwlistout="sudo /sbin/iptables -L OUTPUT -n -v --line-numbers"
alias fwlistfw="sudo /sbin/iptables -L FORWARD -n -v --line-numbers"
alias firewall=fwlist

alias fwblockip="iptables -I INPUT -j DROP -s "
alias fwunblockip="iptables -D INPUT -j DROP -s "

function fw_open_ip_port() {
    if [ $# -ne 2 ]; then
        echo "usage: fw_open_ip_port <source> <port>"
        exit 1
    fi
    source=$1
    port=$2
    sudo iptables -A INPUT -s ${source} -p tcp --dport ${port} -j ACCEPT
}