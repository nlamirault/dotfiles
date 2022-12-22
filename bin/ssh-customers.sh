#!/usr/bin/bash

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

NO_COLOR="\033[0m"
DEBUG_COLOR="\e[34m"
INFO_COLOR="\e[32m"
ERROR_COLOR="\e[31m"
WARN_COLOR="\e[35m"

SSH_HOME="${HOME}/.ssh"
SSH_CONF_DIR="conf.d"
SSH_CUSTOMERS_DIR="customers.d"

function usage() {
    echo "Usage: $0 <action> <customer> "
    echo "  action: list, status, enable or disable"
}

action=$1
[ -z "${action}" ] && usage && exit 1

if [ "${action}" == "list" ]; then
    ls ${SSH_HOME}/${SSH_CUSTOMERS_DIR}
    exit
elif [ "${action}" == "status" ]; then
    ls ${SSH_HOME}/${SSH_CONF_DIR}
    exit
fi

customer=$2
[ -z "${customer}" ] && echo "Customer not satisfied" && exit 1

if [ -f "${SSH_HOME}/${SSH_CUSTOMERS_DIR}/${customer}" ]; then
    case ${action} in
        "enable")
            echo -e "${INFO_COLOR}Enable SSH config for: ${customer}${NO_COLOR}"
            ln -s ${SSH_HOME}/${SSH_CUSTOMERS_DIR}/${customer} ${SSH_HOME}/${SSH_CONF_DIR}/${customer}
            ;;
        "disable")
            echo -e "${INFO_COLOR}Disable SSH config for: ${customer}${NO_COLOR}"
            rm ${SSH_HOME}/${SSH_CONF_DIR}/${customer}
            ;;
        *)
            usage
            ;;
    esac
else
    echo -e "${WARN_COLOR}Unknown customer: ${customer}${NO_COLOR}"
fi