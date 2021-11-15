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

#!/bin/bash

# standard bash error handling
# set -o errexit;
set -o pipefail;
set -o nounset;
# debug commands
# set -x;

DEBUG_COLOR="\e[34m"
INFO_COLOR="\e[32m"
ERROR_COLOR="\e[31m"
WARN_COLOR="\e[35m"
NO_COLOR="\e[39m"


function manage_gke() {
    project=$1
    cluster_details=$2
    cluster=${cluster_details[0]}
    zone=${cluster_details[1]}
    master_version=${cluster_details[2]}
    # echo "Length: ${#cluster_details[@]}"
    if [ ${#cluster_details[@]} -ge 4 ]; then
        maintenance_window=$(echo ${cluster_details[3]}|awk -F'=' '{ print $1 }'|sed -e s/\"//g -e "s/u\'//g")
        maintenance_details=$(echo ${cluster_details[3]}|awk -F'=' '{ print $2 }'|awk -F',' '{ print $2 }'|tr -d "}" | tr -d "u'")
        maintenance_policy="Maintenance ${maintenance_window},${maintenance_details}" # ${cluster_details[4]}" ${cluster_details[5]}"
        if [ ${#cluster_details[@]} -ge 5 ]; then
            release_channel="Release ${cluster_details[4]}"
        else
            release_channel="${WARN_COLOR}No Release Channel${NO_COLOR}"
        fi
    else
        maintenance_policy="${WARN_COLOR}No Maintenance Policy${NO_COLOR}"
        release_channel="${WARN_COLOR}No Release Channel${NO_COLOR}"
    fi

    echo -e "${DEBUG_COLOR}GKE${NO_COLOR}: ${cluster} / ${master_version} / ${release_channel} / ${maintenance_policy}"
    pool_list=$(gcloud container node-pools list --project ${project} --zone ${zone} --cluster ${cluster} --format="csv(name)[no-heading]")|| echo -e "${WARN_COLOR}No node pool${NO_COLOR}"
    if [ $? -eq 0 ]; then
        echo -e "${DEBUG_COLOR}Node pool:${NO_COLOR}"
        for pool in ${pool_list}; do
            pool_desc=$(gcloud container node-pools describe ${pool} --project ${project} --zone ${zone} --cluster ${cluster} --format="csv(version,autoscaling,management)[no-heading]")
            pool_details=($(echo ${pool_desc} | tr "," "\n"))
            node_version=${pool_details[0]}
            if [ ${#pool_details[@]} -ge 2 ]; then
                node_autoscaling="Autoscaling: ${pool_details[1]}"
                if [ ${#pool_details[@]} -eq 3 ]; then
                    node_management="Management: ${pool_details[2]}"
                else
                    node_management="${ERROR_COLOR}No Management${NO_COLOR}"
                fi
            else
                node_autoscaling="${ERROR_COLOR}No Autoscaling${NO_COLOR}"
                node_management="${ERROR_COLOR}No Management${NO_COLOR}"
            fi
            echo -e "- ${pool}: ${node_version} / ${node_autoscaling} / ${node_management}"
        done
    fi
}


function manage_gcp_project() {
    project=$1
    echo -e "${INFO_COLOR}== ${project} ==${NO_COLOR}"
    # clusters=$(gcloud beta container clusters list --project ${project} 2>/dev/null --format="csv(name,zone,currentMasterVersion,maintenancePolicy.window,releaseChannel)[separator=';',no-heading]")
    clusters=$(gcloud beta container clusters list --project ${project} --format="csv(name,zone,currentMasterVersion,maintenancePolicy.window,releaseChannel)[separator=';',no-heading]")
    # echo "Clusters : ${clusters}"
    for cluster in ${clusters}; do
        cluster_details=($(echo ${cluster} | tr ";" "\n"))
        manage_gke ${project} ${cluster_details}
    done
}

IFS=$'\n'

echo -e "${INFO_COLOR}[ GKE status ]${NO_COLOR}"

if [ $# -eq 0 ]; then
    projects=$(gcloud projects list --format="value(projectId)")
    for project in ${projects}; do
        manage_gcp_project ${project}
    done
else
    manage_gcp_project $1
fi
