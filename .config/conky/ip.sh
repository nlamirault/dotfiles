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

pingresult=$(ping -c 1 www.google.fr | grep received |cut -d "," -f2 | cut -d " " -f2)
error="Non connecté"
if [[ "$pingresult" == "ping: unknown host www.google.fr" ]]
then
    echo $error
else
    if [[ "$pingresult" == "1" ]]
    then
	wget http://checkip.dyndns.org/ -O - -o /dev/null | cut -d: -f 2 | cut -d\< -f 1 > $HOME/.conky/ip
    else
        echo $error
    fi
fi
